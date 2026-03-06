# --- Variáveis de Configuração ---
DB_URL=postgres://myuser:secret@localhost:5435/greenlight?sslmode=disable
MIGRATIONS_PATH=./db/migrations
SWAG_MAIN=./cmd/server/main.go

# Variáveis de Ambiente para o run-local
export REDIS_HOST=localhost
export POSTGRES_DB=greenlight
export POSTGRES_USER=myuser
export POSTGRES_PASSWORD=secret
export POSTGRES_PORT=5435
export POSTGRES_HOST=localhost
export JWT_SECRET_KEY=ObL89O3nOSSEj6tbdHako0cXtPErzBUfq8l8o/3KD9g=INSECURE
export API_SECRET_KEY=cJGZ8L1sDcPezjOy1zacPJZxzZxrPObm2Ggs1U0V+fE=INSECURE

.PHONY: setup migrate-up migrate-down migrate-create build-docker run-local up down restart build test clean

# --- Setup e Documentação ---
setup:
	go install github.com/swaggo/swag/cmd/swag@latest
	swag init -g $(SWAG_MAIN) -o ./docs
	go get -u github.com/swaggo/gin-swagger
	go get -u github.com/swaggo/files
	go mod tidy
		

# --- Desenvolvimento Local ---
run-local:
	docker start dockerPostgres || true
	docker start dockerRedis || true
	docker start dockerMongo || true
	go run $(SWAG_MAIN)

# --- Docker / docker Compose ---
build-docker:
	docker-compose build --no-cache

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

# --- Build e Testes ---
build:
	go build -v ./...

test:
	go test -v ./... -race -cover

clean:
	docker stop go-rest-api-template dockerPostgres dockerRedis || true
	docker rm go-rest-api-template dockerPostgres dockerRedis || true
	docker image rm golang-rest-api-template-backend || true
	rm -rf .dbdata