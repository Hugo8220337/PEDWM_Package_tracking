package main

import (
	"basicAPI/internal/handlers"

	"github.com/gin-gonic/gin"
)

func setupRouter(h *handlers.Container) *gin.Engine {
	// Create a new router using the Gin framework
	r := gin.Default()

	// To return a 405 Method Not Allowed response for unsupported HTTP methods
	r.HandleMethodNotAllowed = true

	// Health Check Endpoint
	r.GET("/v1/healthcheck", h.HealthCheck.HealthCheck)

	// Parcel Endpoints
	r.POST("/v1/parcels", h.Parcel.CreateParcel)
	r.GET("/v1/parcels/:code", h.Parcel.ShowParcel)
	return r
}
