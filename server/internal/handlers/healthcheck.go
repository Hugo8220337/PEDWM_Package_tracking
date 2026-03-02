package handlers

import (
	db "basicAPI/db/sqlc"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type HealthCheckHandler struct {
	Queries *db.Queries
	Logger  *log.Logger
}

type HealthCheckResponse struct {
	Status string `json:"status"`
	// Environment string `json:"environment"`
	// Version     string `json:"version"`
}

func (h *HealthCheckHandler) HealthCheck(c *gin.Context) {
	env := HealthCheckResponse{
		Status: "available",
		// Environment: "development",
		// Version:     "1.0.0",
	}

	c.JSON(http.StatusOK, env)
}
