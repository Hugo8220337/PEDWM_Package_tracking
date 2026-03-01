package handlers

import (
	db "basicAPI/db/sqlc"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type UserHandler struct {
	Queries *db.Queries
	Logger  *log.Logger
}

func (h *UserHandler) CreateUser(c *gin.Context) {
	var input struct {
		Name         string `json:"name"`
		Email        string `json:"email"`
		PasswordHash []byte `json:"password_hash"`
		Activated    bool   `json:"activated"`
	}

	// Bind the JSON payload to the input struct. If there is an error during binding, return a 400 Bad Request response with an error message.
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Dados inválidos"})
		return
	}

	user, err := h.Queries.CreateUser(c.Request.Context(), db.CreateUserParams{
		Name:         input.Name,
		Email:        input.Email,
		PasswordHash: []byte("teste"),
		Activated:    true,
	})

	if err != nil {
		h.Logger.Printf("ERROR: handlers.CreateUser: %v", err)

		c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro ao processar o pedido"})
		return
	}

	c.JSON(http.StatusCreated, user)
}
