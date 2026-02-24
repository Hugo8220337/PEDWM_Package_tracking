# --- Variáveis de Configuração ---
DB_URL=postgres://myuser:secret@localhost/greenlight?sslmode=disable
MIGRATIONS_PATH=./migrations
SWAG_MAIN=./cmd/server/main.go

# Variáveis de Ambiente para o run-local
export REDIS_HOST=localhost
export POSTGRES_DB=go_app_dev
export POSTGRES_USER=docker
export POSTGRES_PASSWORD=password
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

# --- Banco de Dados (Migrations) ---
migrate-up:
	podman run --rm -v "$(PWD)/$(MIGRATIONS_PATH):/migrations" --network host docker.io/migrate/migrate \
		-path=/migrations/ -database "$(DB_URL)" up

migrate-down:
	podman run --rm -v "$(PWD)/$(MIGRATIONS_PATH):/migrations" --network host docker.io/migrate/migrate \
		-path=/migrations/ -database "$(DB_URL)" down 1

migrate-create:
	podman run --rm -v "$(PWD)/$(MIGRATIONS_PATH):/migrations" docker.io/migrate/migrate \
		create -ext sql -dir /migrations/ -seq $(name)
migrate-version:
	podman run --rm -v "$(PWD)/$(MIGRATIONS_PATH):/migrations" --network host docker.io/migrate/migrate \
		-path=/migrations/ -database "$(DB_URL)" version
migrate-goto:
	podman run --rm -v "$(PWD)/$(MIGRATIONS_PATH):/migrations" --network host docker.io/migrate/migrate \
		-path=/migrations/ -database "$(DB_URL)" goto $(version)

# --- Desenvolvimento Local ---
run-local:
	podman start dockerPostgres || true
	podman start dockerRedis || true
	podman start dockerMongo || true
	go run $(SWAG_MAIN)

# --- Docker / Podman Compose ---
build-docker:
	podman-compose build --no-cache

up:
	podman-compose up -d

down:
	podman-compose down

restart:
	podman-compose restart

# --- Build e Testes ---
build:
	go build -v ./...

test:
	go test -v ./... -race -cover

clean:
	podman stop go-rest-api-template dockerPostgres dockerRedis || true
	podman rm go-rest-api-template dockerPostgres dockerRedis || true
	podman image rm golang-rest-api-template-backend || true
	rm -rf .dbdata