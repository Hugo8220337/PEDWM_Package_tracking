package handlers

import (
	db "basicAPI/db/sqlc"
	"database/sql"
	"errors"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type MovieHandler struct {
	Queries *db.Queries
	Logger  *log.Logger
}

// Serve como DTO
type MovieRequest struct {
	Title   string   `json:"title" binding:"required,max=200"`
	Year    int32    `json:"year" binding:"required,min=1888,max=2100"`
	Runtime int32    `json:"runtime" binding:"required,min=3"`
	Genres  []string `json:"genres" binding:"required,min=1,max=5"`
}

func (h *MovieHandler) ShowMovie(c *gin.Context) {
	id := c.Param("id")

	// convert id string to int64
	idInt, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	movie, err := h.Queries.GetMovie(c.Request.Context(), idInt)
	if err != nil {
		// VERIFICAÇÃO DO 404 AQUI:
		if errors.Is(err, sql.ErrNoRows) {
			c.JSON(http.StatusNotFound, gin.H{"error": "Movie not found"})
			return
		}

		// Se não for "Not Found", então sim, é um erro interno (500)
		h.Logger.Printf("ERROR: handlers.ShowMovie: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error while processing the request"})
		return
	}

	c.JSON(http.StatusOK, movie)
}

func (h *MovieHandler) ListMovies(c *gin.Context) {
	// Get limit and offset from query parameters
	p := GetPagination(c)
	arg := db.ListMoviesParams{
		Limit:  p.Limit,
		Offset: p.Offset,
	}

	movies, err := h.Queries.ListMovies(c.Request.Context(), arg)
	if err != nil {
		h.Logger.Printf("ERROR: handlers.listMovies: %v", err)

		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error while fetching movies"})
		return
	}

	c.JSON(http.StatusOK, movies)
}

func (h *MovieHandler) CreateMovie(c *gin.Context) {
	var input MovieRequest

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body", "details": FormatValidationError(err)})
		return
	}

	movie, err := h.Queries.CreateMovie(c.Request.Context(), db.CreateMovieParams{
		Title:   input.Title,
		Year:    input.Year,
		Runtime: input.Runtime,
		Genres:  input.Genres,
	})

	if err != nil {
		h.Logger.Printf("ERROR: handlers.CreateMovie: %v", err)

		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error while creating movie"})
		return
	}

	c.JSON(http.StatusCreated, movie)
}

func (h *MovieHandler) UpdateMovie(c *gin.Context) {
	id := c.Param("id")

	// convert id string to int64
	idInt, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var input MovieRequest
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body", "details": FormatValidationError(err)})
		return
	}

	movie, err := h.Queries.UpdateMovie(c.Request.Context(), db.UpdateMovieParams{
		ID:      idInt,
		Title:   input.Title,
		Year:    input.Year,
		Runtime: input.Runtime,
		Genres:  input.Genres,
	})

	if err != nil {
		// Se tentou atualizar um ID que não existe na BD
		if errors.Is(err, sql.ErrNoRows) {
			c.JSON(http.StatusNotFound, gin.H{"error": "Movie not found"})
			return
		}

		h.Logger.Printf("ERROR: handlers.UpdateMovie: %v", err)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error while updating movie"})
		return
	}

	c.JSON(http.StatusOK, movie)
}

func (h *MovieHandler) DeleteMovie(c *gin.Context) {
	id := c.Param("id")

	idInt, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	err = h.Queries.DeleteMovie(c.Request.Context(), idInt)
	if err != nil {
		h.Logger.Printf("ERROR: handlers.DeleteMovie: %v", err)

		c.JSON(http.StatusInternalServerError, gin.H{"error": "Error while deleting movie"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Movie deleted successfully"})
}
