package main

import (
	"basicAPI/internal/handlers"
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func setupRouter(h *handlers.Container) *gin.Engine {
	// Create a new router using the Gin framework
	r := gin.Default()

	// CORS Middleware Configuration
	r.Use(cors.New(cors.Config{
		// Se fosse para produção mudava para []string{"https://omeusite.com"}
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour, // O browser faz cache destas regras por 12h
	}))

	// To return a 405 Method Not Allowed response for unsupported HTTP methods
	r.HandleMethodNotAllowed = true

	// Health Check Endpoint
	r.GET("api/v1/healthcheck", h.HealthCheck.HealthCheck)

	// Parcel Endpoints
	r.POST("api/v1/parcels", h.Parcel.CreateRandomParcel)
	r.GET("api/v1/parcels/:code", h.Parcel.ShowParcel)

	return r
}
