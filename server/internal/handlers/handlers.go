package handlers

import (
	"basicAPI/ent"
	"log/slog"
)

// Usa o padrão de injeção de dependências para criar handlers que dependem das queries da base de dados

// Container guarda todos os handlers da aplicação
type Container struct {
	HealthCheck *HealthCheckHandler
	Parcel      *ParcelHandler
	// Product *ProductHandler
	// Auth    *AuthHandler
}

// NewContainer centraliza a criação de todos os handlers
func NewContainer(client *ent.Client, logger *slog.Logger) *Container {
	return &Container{
		HealthCheck: &HealthCheckHandler{
			Client: client,
			Logger: logger,
		},

		Parcel: &ParcelHandler{
			Client: client,
			Logger: logger,
		},
	}
}
