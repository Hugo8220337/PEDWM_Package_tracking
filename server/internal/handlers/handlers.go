package handlers

import (
	db "basicAPI/db/sqlc"
	"log"
)

// Usa o padrão de injeção de dependências para criar handlers que dependem das queries da base de dados

// Container guarda todos os handlers da aplicação
type Container struct {
	User        *UserHandler
	Movie       *MovieHandler
	HealthCheck *HealthCheckHandler
	// Product *ProductHandler
	// Auth    *AuthHandler
}

// NewContainer centraliza a criação de todos os handlers
func NewContainer(queries *db.Queries, logger *log.Logger) *Container {
	return &Container{
		HealthCheck: &HealthCheckHandler{
			Queries: queries,
			Logger:  logger,
		},
		User: &UserHandler{
			Queries: queries,
			Logger:  logger,
		},

		Movie: &MovieHandler{
			Queries: queries,
			Logger:  logger,
		},
	}
}
