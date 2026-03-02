package handlers

import (
	db "basicAPI/db/sqlc"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Estas Structs servem como injeção de dependências para os handlers
type UserHandler struct {
	Queries *db.Queries
	Logger  *log.Logger
}

type UserRequest struct {
	Name         string `json:"name" binding:"required,max=100"`
	Email        string `json:"email" binding:"required,email"`
	PasswordHash string `json:"password_hash" binding:"required"`
	Activated    bool   `json:"activated" binding:"required"`
}

func (h *UserHandler) CreateUser(c *gin.Context) {

	// Bind the JSON payload to the input struct. If there is an error during binding, return a 400 Bad Request response with an error message.
	var input UserRequest
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body", "details": FormatValidationError(err)})
		return
	}

	user, err := h.Queries.CreateUser(c.Request.Context(), db.CreateUserParams{
		Name:         input.Name,
		Email:        input.Email,
		PasswordHash: []byte(input.PasswordHash),
		Activated:    input.Activated,
	})

	if err != nil {
		h.Logger.Printf("ERROR: handlers.CreateUser: %v", err)

		c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao processar o pedido"})
		return
	}

	c.JSON(http.StatusCreated, user)
}
