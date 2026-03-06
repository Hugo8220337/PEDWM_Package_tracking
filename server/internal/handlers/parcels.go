package handlers

import (
	"log/slog"
	"net/http"

	"basicAPI/ent"

	"basicAPI/ent/parcel"

	"github.com/gin-gonic/gin"
)

// ParcelHandler guarda as dependências para as rotas de encomendas
type ParcelHandler struct {
	Client *ent.Client
	Logger *slog.Logger
}

// DTO para a criação da encomenda
type CreateParcelRequest struct {
	TrackingNumber string `json:"tracking_number" binding:"required,min=5"`
}

// CreateParcel cria uma nova encomenda na base de dados
func (h *ParcelHandler) CreateParcel(c *gin.Context) {
	var input CreateParcelRequest
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Dados inválidos", "details": FormatValidationError(err)})
		return
	}

	// A MAGIA DO ENT: Criar um registo de forma orientada a objetos
	pkg, err := h.Client.Parcel.Create().
		SetTrackingNumber(input.TrackingNumber).
		// O Status e o CreatedAt assumem os Defaults que definiste no esquema!
		Save(c.Request.Context())

	if err != nil {
		// O Ent sabe se falhou a regra de Unique do TrackingNumber, por exemplo
		if ent.IsConstraintError(err) {
			c.JSON(http.StatusConflict, gin.H{"error": "Este código de tracking já existe"})
			return
		}

		h.Logger.Error("erro ao criar encomenda", "error", err.Error())
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro interno ao gravar a encomenda"})
		return
	}

	c.JSON(http.StatusCreated, pkg)
}

// ShowParcel procura uma encomenda pelo seu código de tracking
func (h *ParcelHandler) ShowParcel(c *gin.Context) {
	trackingCode := c.Param("code") // Puxa da URL (ex: /Parcels/TRK-123)

	// A MAGIA DO ENT: Fazer um SELECT com um WHERE específico
	pkg, err := h.Client.Parcel.Query().
		Where(parcel.TrackingNumberEQ(trackingCode)). // WHERE tracking_number = $1
		Only(c.Request.Context())                     // Pede apenas 1 resultado (ou erro se não existir)

	if err != nil {
		// Se não encontrar nada, o Ent devolve um NotFoundError específico
		if ent.IsNotFound(err) {
			c.JSON(http.StatusNotFound, gin.H{"error": "Encomenda não encontrada"})
			return
		}

		h.Logger.Error("erro ao procurar encomenda", "error", err.Error(), "codigo", trackingCode)
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Erro interno ao pesquisar"})
		return
	}

	c.JSON(http.StatusOK, pkg)
}
