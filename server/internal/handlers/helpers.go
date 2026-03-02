package handlers

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
)

// Pagination guarda os valores extraídos e validados do URL
type Pagination struct {
	Limit  int32 `form:"limit,default=20"`
	Offset int32 `form:"offset,default=0"`
}

// GetPagination extrai os dados do Gin e aplica regras de segurança
func GetPagination(c *gin.Context) Pagination {
	var p Pagination

	// O Gin preenche a struct e aplica os defaults (20 e 0)
	// Se der erro (ex: utilizador enviou letras em vez de números),
	// ignoramos o erro e o Gin usa os defaults na mesma.
	_ = c.ShouldBindQuery(&p)

	// Regras de Segurança (Muito importante em produção!)
	if p.Limit <= 0 {
		p.Limit = 20
	}
	if p.Limit > 100 {
		p.Limit = 100 // Máximo absoluto permitido por pedido
	}
	if p.Offset < 0 {
		p.Offset = 0
	}

	return p
}

func FormatValidationError(err error) map[string]string {
	errors := make(map[string]string)

	// Verifica se o erro é do tipo ValidationErrors
	if errs, ok := err.(validator.ValidationErrors); ok {
		for _, e := range errs {
			// e.Field() é o nome do campo (ex: "Year")
			// e.Tag() é a regra que falhou (ex: "min")
			errors[e.Field()] = "Failed validation rule: " + e.Tag()
		}
		return errors
	}

	// Se for outro erro (ex: JSON mal formatado, faltam aspas, etc)
	return map[string]string{"format": "Invalid request format or missing fields"}
}
