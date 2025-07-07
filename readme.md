# MySQL Project

This project contains a MySQL database setup using Docker, along with schema definitions, query files, and database diagrams.

## 🚀 Getting Started

### 1. Spin Up the MySQL Container

To start the MySQL service using Docker:

```bash
docker-compose up -d
```
This will spin up the containers marked in the docker-compose.yml file
in detached mode

To stop the containers run:

```bash
docker-compose down
```

To connect to the db using mysql cli app:

```bash
mysql -h {host} -P {port} -u {user-name} -p 
mysql -h 127.0.0.1 -P 3306 -u myuser -p
```
Command arguments:
 - Replace {host} with the host or ip of the container
 - Replace {port} with the port of the container
 - Replace {username} with the user of the mysql db



To Remove the database and the volume
- stop the containers
- sudo rm -rf ./mysql-data (the folder with the db volume)
