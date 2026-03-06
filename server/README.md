# Parei no Capítulo 8 página 164

Directories:
- `bin:` compiled application binnaries, ready for the production server
- `md/api`: application code for the API application. This include the code to run the server, reading and writing HTTP requests, and managing authentication
- `internal`: contain various packages used by the API. Contain code to interact with the database, doing data validation, sending emails and so on. Basically, any code wich isn't application-specific and can potentially be reused will live in here. Our Go code under `cmd/api` will import packages in the internal directory (but never the other way around)
- `migrations`: contain the SQL migration files for the database
- `remote`: contain configuration files and setup scripts for the production server
- `go.mod`: declare project dependecies, versions and module path
- `Makefile`: contain recipes for automating common administrative tasks - like auditing our Go code, building binaries, and executing database migrations.

Directories, under golang documentation:
- /cmd --> Contains the app's entry-points 
  |- /server
     |- /docs
     |- main.go
     |- Makefile
  |- /another_binary
- /config --> Contains the config structures that the server uses.
- internal --> Contains the app's code
   |- /errors
   |- /handlers
   |- /middleware
   |- /model
   |- /storage
   |- server.go
- /logs --> The folder's files are not in version control. Here you'll have the logs of the apps (the ones you specify to be external)
- /migrations --> Migrations to set up the database schema in your db.
- /pkg --> Packages used in /internal
   |- /httputils
   |- /logger
- .air.toml
- .env --> Not in version control. Need to create your own - see below.
- .gitignore
- docker-compose.yml
- Dockerfile
- go.mod
- go.sum
- LICENSE
- README.md

Dependencies:
    dev:
        - `go get -d ./...`


notes:
    - `go mod init <module-name>`

build and run the docker containers:
    - `make up` <!--TODO ainda não configurei isto-->

## Basic Commands
Como correr a aplicação
- `go run ./cmd/api`
 
## Ent Commands
Create New Entity:
- `go run entgo.io/ent/cmd/ent new «PackageName»`

Gerar Código:
- `go generate ./ent`