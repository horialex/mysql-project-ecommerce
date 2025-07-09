# Database project - MySQL

Business: E-Commerce Store


Practic o sa incep prin a defini un concept de busienss pe care sa il modelez intr-o baza de date.
Ideea e sa inteleg la inceput entitatile, ce proprietati au si cum interactioneaza intre ele.


## Un e-commerce business are urmatoarele entitati:

- Customers — oameni care cumpara
- Products — ce se poate cumpara 
- Orders — comenzile cumparaturilor facute de clienti
- Order Items — legatura dintre comenzi si produse
- Categories — categoriile produselor
- Status - ce status poate avea comanda: eg: pending, fulfilled etc
- (Optionally) Reviews, Shopping Carts, Addresses, etc.


## Tabelele principale:

- Customers - Stocheaza datele despre clienti (nume, email, telefon, adresa)
- Products - Stocheaza datele despre produse (nume, pret, cantitate disponibila, categorie)
- Categories - Grupeaza produsele (nume, descriere)
- Orders - Informatii gneerale de pe o comanda (data comenzii, statis, cutomer ID)
- OrderItems - Produse cu o factura (Product ID, quantity, price) - ??, aici poate putem pune tot pe Orders


🔗 Relațiile între entități:
- Un Customer poate plasa mai multe Orders (One-to-Many)
- Un Order conține mai multe OrderItems (One-to-Many)
- Un OrderItem este legat de un singur Product (Many-to-One)
- Un Product aparține unei Category, iar o Category poate avea mai multe Products (One-to-Many)
- Un Order are un Status din OrderStatus, dar un Status poate fi folosit de mai multe Orders (Many-to-One)


## Procesul de business

1. Un Customer navigheaza prin site si cauta Products(organizate pe categorii)
2. Un Cusomter adauga Produse in cart-ul lor, apoi creeaza un Order
3. Order-ul contine Order Items, (una pt fiecare Produs)
4. Order-ul este stocat si statusul este updatat(Processing, Shipped, Completed)


OrderItems - Tabel de legatura intre Orders si Items

- Un Order poate avea mai multe Products
- Un Product poate aparea pe mai multe Orders
- Fara acest table practic un client poate cumpara un singur produs pe un Order
- OrderItems este ca un pod intre cele doua tabele
- Are order_id care indica catre un Order record
- Are product_id care indica catre un Product record
- adauga detalii precum cantitate, pret la momentul efectuarii comenzii


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

## SQL Schema


