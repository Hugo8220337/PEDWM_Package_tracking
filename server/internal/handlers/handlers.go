package handlers

import (
	db "basicAPI/db/sqlc"
	"log"
)

// Usa o padrão de injeção de dependências para criar handlers que dependem das queries da base de dados

// Container guarda todos os handlers da aplicação
type Container struct {
	User *UserHandler
	// Product *ProductHandler
	// Auth    *AuthHandler
}

// NewContainer centraliza a criação de todos os handlers
func NewContainer(queries *db.Queries, logger *log.Logger) *Container {
	return &Container{
		User: &UserHandler{
			Queries: queries,
			Logger:  logger, // Injetamos o logger aqui
		},
	}
}
