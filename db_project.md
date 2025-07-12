# Database project - MySQL

💰 Business: E-Commerce Store 

Practic o sa incep prin a defini un concept de business pe care sa il modelez intr-o baza de date.
Ideea e sa inteleg la inceput entitatile, ce proprietati au si cum interactioneaza intre ele.
Scopul acestui proiect este sa invat cat mai multe despre bazele de date si mysql printr-un proiect
aplicat pe o idee practica, usor de inteles.



## Un e-commerce business are urmatoarele entitati:

- Customers — oameni care cumpara
- Products — ce se poate cumpara 
- Orders — comenzile cumparaturilor facute de clienti
- Order Items — legatura dintre comenzi si produse
- Categories — categoriile produselor
- Status - ce status poate avea comanda: eg: pending, fulfilled etc
- (Optional) Reviews, Shopping Carts, Addresses, etc.


## Tabelele principale:

- Customers - Stocheaza datele despre clienti (nume, email, telefon, adresa)
- Products - Stocheaza datele despre produse (nume, pret, cantitate disponibila, categorie)
- Categories - Categoriile de produsele (nume, descriere)
- Orders - Informatii gneerale de pe o comanda (data comenzii, statis, cutomer ID)
- OrderItems - Contine fiecare element de pe o comanda
- OrderStatus - Statusurile posibile ale unei comenzi


🔗 Relațiile între entități:
- Un Customer poate plasa mai multe Orders (One-to-Many)
- Un Order conține mai multe OrderItems (One-to-Many)
- Un OrderItem este legat de un singur Product (Many-to-One)
- Un Product aparține unei Category, iar o Category poate avea mai multe Products (One-to-Many)
- Un Order are un Status din OrderStatus, dar un Status poate fi folosit de mai multe Orders (Many-to-One)


## Procesul de business

1. Un Customer navigheaza prin site si cauta Products(organizate pe categorii)
2. Un Customer adauga Produse in cart-ul lor, apoi creeaza un Order
3. Order-ul contine Order Items, (una pt fiecare Produs)
4. Order-ul este stocat initial cu statusul "Pending" iar acesta se updateaza in functie de evolutia comenzii


OrderItems - Tabel de legatura intre Orders si Items

- Un Order poate avea mai multe Products
- Un Product poate aparea pe mai multe Orders
- Fara acest table practic un client poate cumpara un singur produs pe un Order
- OrderItems este ca un pod intre cele doua tabele
- Are order_id care indica catre un Order record
- Are product_id care indica catre un Product record
- adauga detalii precum cantitate, pret la momentul efectuarii comenzii

## 📌 Informații suplimentare de adăugat în documentație:

### 🔐 Constrângeri de integritate și validare

- Fiecare email din Customers trebuie să fie unic (UNIQUE)
- category_id din Products trebuie să existe în Categories (constrângere de cheie externă)
- product_id și order_id din OrderItems trebuie să existe în Products, respectiv Orders

### 🛡️ Regului la stergere (ON DELETE, ON UPDATE)

- ON DELETE CASCADE în OrderItems ⇒ când se șterge o comandă, se șterg și elementele de pe acea comanda
- ON DELETE RESTRICT ⇒ nu se permite ștergerea unui produs dacă apare în OrderItems - TODO: aici ar trebui sa modific si sa adaug  - nu se poate sterge produsul daca comanda nu este in Status = fulfilled, cancelled sau rejected
- ON DELETE SET NULL în Products.category_id ⇒ dacă o categorie este ștearsă, produsele rămân, dar fără categorie


### ⚙️ Triggere
-  Copierea prețului produsului în OrderItems 

Pentru a păstra prețul corect al produsului la momentul plasării comenzii, am implementat un trigger care se activează înainte de inserarea unui nou rând în tabelul OrderItems.

Acest trigger preia automat prețul curent al produsului din tabelul Products și îl setează în câmpul price din OrderItems. Astfel, chiar dacă prețul produsului se modifică ulterior, comanda va reflecta valoarea exactă de la momentul achiziției.


## Diagrama ERD - Marmeid

erDiagram
    Customers {
        INT id PK "AUTO_INCREMENT"
        VARCHAR firstName "NOT NULL"
        VARCHAR lastName "NOT NULL"
        VARCHAR email "NOT NULL UNIQUE"
        VARCHAR address "NOT NULL"
        VARCHAR phone "NOT NULL"
    }
    
    Categories {
        SMALLINT id PK "AUTO_INCREMENT"
        VARCHAR name "NOT NULL"
        TEXT description "NOT NULL"
    }
    
    Products {
        INT id PK "AUTO_INCREMENT"
        SMALLINT category_id FK "NOT NULL"
        VARCHAR sku "UNIQUE"
        VARCHAR name "NOT NULL"
        TEXT description "NOT NULL"
        DECIMAL price "NOT NULL"
    }
    
    OrderStatus {
        TINYINT id PK "AUTO_INCREMENT"
        VARCHAR name "NOT NULL UNIQUE"
    }
    
    Orders {
        INT id PK "AUTO_INCREMENT"
        INT customer_id FK "NOT NULL"
        DATETIME date "DEFAULT CURRENT_TIMESTAMP"
        TINYINT status_id FK "DEFAULT 1"
    }
    
    OrderItems {
        INT id PK "AUTO_INCREMENT"
        INT order_id FK "NOT NULL"
        INT product_id FK "NOT NULL"
        SMALLINT quantity "NOT NULL"
        DECIMAL price "NOT NULL"
    }
    
    %% Relationships
    Customers ||--o{ Orders : "places"
    Categories ||--o{ Products : "contains"
    OrderStatus ||--o{ Orders : "has"
    Orders ||--o{ OrderItems : "contains"
    Products ||--o{ OrderItems : "included_in"


## 📈 Sugestii de imbunatatire si extindere
- Adauga stoc disponibil pe tabela Products
- Adauga Created at si Updated at - pt trasabilitate - posibil pt toate tabelele?
- Adăugare tabel de Reviews pentru produse
- Adăugare tabel de Discounts sau Coupons
- Adăugare tabel de Addresses separate de Customers pentru mai multe adrese de livrare
- Adauga tabel OrderStatusHistory pentru a stoca parcurusul unei comenzi