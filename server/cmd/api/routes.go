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

	// Movie Endpoints
	r.GET("/v1/movies", h.Movie.ListMovies)
	r.POST("/v1/movies", h.Movie.CreateMovie)
	r.GET("/v1/movies/:id", h.Movie.ShowMovie)
	r.PUT("/v1/movies/:id", h.Movie.UpdateMovie)
	r.DELETE("/v1/movies/:id", h.Movie.DeleteMovie)

	// User Endpoints
	r.POST("/v1/users", h.User.CreateUser)

	return r
}
