package handlers

import (
	db "basicAPI/db/sqlc"
	"database/sql"
	"errors"
	"log/slog"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type MovieHandler struct {
	Queries *db.Queries
	Logger  *slog.Logger
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
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  http.StatusBadRequest,
			"error":   "Invalid ID",
			"details": FormatValidationError(err),
		})
		return
	}

	movie, err := h.Queries.GetMovie(c.Request.Context(), idInt)
	if err != nil {
		// 404 Verification (sql.ErrNoRows))
		if errors.Is(err, sql.ErrNoRows) {
			c.JSON(http.StatusNotFound, gin.H{
				"status":  http.StatusNotFound,
				"error":   "Movie not found",
				"details": FormatValidationError(err),
			})
			return
		}

		// Se não for "Not Found", então sim, é um erro interno (500)
		h.Logger.Warn("Invalid ID or error fetching movie",
			slog.String("param_id", id),
			slog.String("client_ip", c.ClientIP()),
		)
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  http.StatusInternalServerError,
			"error":   "Error while processing the request",
			"details": FormatValidationError(err),
		})
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
		h.Logger.Warn("Error while fetching movies",
			slog.String("error", err.Error()),
		)

		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  http.StatusInternalServerError,
			"error":   "Error while fetching movies",
			"details": FormatValidationError(err),
		})
		return
	}

	c.JSON(http.StatusOK, movies)
}

func (h *MovieHandler) CreateMovie(c *gin.Context) {
	var input MovieRequest

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  http.StatusBadRequest,
			"error":   "Invalid request body",
			"details": FormatValidationError(err),
		})
		return
	}

	movie, err := h.Queries.CreateMovie(c.Request.Context(), db.CreateMovieParams{
		Title:   input.Title,
		Year:    input.Year,
		Runtime: input.Runtime,
		Genres:  input.Genres,
	})

	if err != nil {
		h.Logger.Warn("Error while creating movie",
			slog.String("error", err.Error()),
			slog.String("title", input.Title),
		)

		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  http.StatusInternalServerError,
			"error":   "Error while creating movie",
			"details": FormatValidationError(err),
		})
		return
	}

	c.JSON(http.StatusCreated, movie)
}

func (h *MovieHandler) UpdateMovie(c *gin.Context) {
	id := c.Param("id")

	// convert id string to int64
	idInt, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  http.StatusBadRequest,
			"error":   "Invalid ID",
			"details": FormatValidationError(err),
		})
		return
	}

	var input MovieRequest
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  http.StatusBadRequest,
			"error":   "Invalid request body",
			"details": FormatValidationError(err),
		})
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
			c.JSON(http.StatusNotFound, gin.H{
				"status":  http.StatusNotFound,
				"error":   "Movie not found",
				"details": FormatValidationError(err),
			})
			return
		}

		h.Logger.Warn("Error while updating movie",
			slog.String("error", err.Error()),
			slog.String("title", input.Title),
		)
		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  http.StatusInternalServerError,
			"error":   "Error while updating movie",
			"details": FormatValidationError(err),
		})
		return
	}

	c.JSON(http.StatusOK, movie)
}

func (h *MovieHandler) DeleteMovie(c *gin.Context) {
	id := c.Param("id")

	idInt, err := strconv.ParseInt(id, 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"status":  http.StatusBadRequest,
			"error":   "Invalid ID",
			"details": FormatValidationError(err),
		})
		return
	}

	err = h.Queries.DeleteMovie(c.Request.Context(), idInt)
	if err != nil {
		h.Logger.Warn("Error while deleting movie",
			slog.String("error", err.Error()),
		)

		c.JSON(http.StatusInternalServerError, gin.H{
			"status":  http.StatusInternalServerError,
			"error":   "Error while deleting movie",
			"details": FormatValidationError(err),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Movie deleted successfully"})
}
