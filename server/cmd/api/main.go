package main

import (
	"basicAPI/ent"
	"basicAPI/internal/handlers"
	"context"
	"flag"
	"fmt"
	"log/slog"
	"net/http"
	"net/url"
	"os"
	"time"

	_ "github.com/lib/pq" // Driver standard do Postgres necessário para o Ent
)

// TODO try to generate this later at compile time
const version = "1.0.0"

// Configuration Settings fot the application
type config struct {
	port int
	env  string
	db   struct {
		dsn          string
		maxOpenConns int
		maxIdleConns int
		maxIdleTime  string
	}
}

// This servers for the application to hold dependecies for the HTTP handlers, helpers and middleware
// This is a Singleton, so we only have one instance of it in the application.
type application struct {
	config    config
	logger    *slog.Logger
	entClient *ent.Client
	handlers  *handlers.Container
}

func main() {
	// Instance of the config struct
	var cfg config

	// --- Configure Environment Variables ---
	// Read the value of the port and env command-line flags into the config struct.
	// 4000 is the default port for development environment if no corresponding flags are provided
	flag.IntVar(&cfg.port, "port", 4000, "API Server port")
	flag.StringVar(&cfg.env, "env", "development", "Environment (development|staging|production)")
	flag.StringVar(&cfg.db.dsn, "db-dsn", os.Getenv("POSTGRES_DB_DSN"), "PostgreSQL DSN")
	if cfg.db.dsn == "" {
		cfg.db.dsn = buildPostgresDSN()
	}
	flag.IntVar(&cfg.db.maxOpenConns, "db-max-open-conns", 25, "PostgreSQL max open connections")
	flag.IntVar(&cfg.db.maxIdleConns, "db-max-idle-conns", 25, "PostgreSQL max idle connections")
	flag.StringVar(&cfg.db.maxIdleTime, "db-max-idle-time", "15m", "PostgreSQL max idle time")

	flag.Parse()

	// Criar um logger que cospe JSON para o Stdout
	jsonHandler := slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
		Level: slog.LevelInfo, // isto poderia ser uma variável de ambiente
	})
	logger := slog.New(jsonHandler)

	// Configure Database Connection Pool
	client, err := openDB(cfg)
	if err != nil {
		logger.Error("Unable to connect to database or run migrations", "error", err.Error())
		os.Exit(1) // Parar o servidor se a BD falhar
	}
	defer client.Close()

	// Create instance of the handlers container
	hContainer := handlers.NewContainer(client, logger)

	// Create a new instance of the application struct, which is a custom struct that we have defined to hold all of our application dependencies. We pass the config, logger, database connection pool, and handlers container to it.
	app := &application{
		config:    cfg,
		logger:    logger,
		entClient: client,
		handlers:  hContainer,
	}

	// Execute HTTP Server
	err = app.serve()
	if err != nil {
		logger.Error("Server Error", "error", err.Error())
	}
}

func (app *application) serve() error {
	srv := &http.Server{
		Addr:         fmt.Sprintf(":%d", app.config.port),
		Handler:      setupRouter(app.handlers),
		IdleTimeout:  time.Minute,
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 30 * time.Second,
	}

	app.logger.Info("starting server", "environment", app.config.env, "address", srv.Addr)
	return srv.ListenAndServe()
}

func openDB(cfg config) (*ent.Client, error) {
	// 1. Abrir a ligação com o driver "postgres"
	client, err := ent.Open("postgres", cfg.db.dsn)
	if err != nil {
		return nil, fmt.Errorf("failed opening connection to postgres: %w", err)
	}

	// 2. A MAGIA DO ENT (Auto-Migração):
	// Isto lê o teu código Go e cria/atualiza as tabelas no Postgres automaticamente!
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := client.Schema.Create(ctx); err != nil {
		return nil, fmt.Errorf("failed creating schema resources: %w", err)
	}

	return client, nil
}

func buildPostgresDSN() string {
	host := envOrDefault("DB_HOST", "localhost")
	port := envOrDefault("DB_PORT", "5435")
	user := envOrDefault("DB_USER", "myuser")
	password := envOrDefault("DB_PASSWORD", "secret")
	dbName := envOrDefault("DB_NAME", "greenlight")
	sslMode := envOrDefault("DB_SSLMODE", "disable")

	credentials := url.UserPassword(user, password)
	return fmt.Sprintf("postgres://%s@%s:%s/%s?sslmode=%s", credentials.String(), host, port, dbName, sslMode)
}

func envOrDefault(name, fallback string) string {
	value := os.Getenv(name)
	if value == "" {
		return fallback
	}
	return value
}
