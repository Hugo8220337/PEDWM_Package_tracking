package handlers

import (
	"encoding/json"
	"errors"
	"io"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
)

/**
* Pagination struct is used to hold the pagination parameters extracted from the query string.
 */
type Pagination struct {
	Limit  int32 `form:"limit,default=20"`
	Offset int32 `form:"offset,default=0"`
}

/*
* Extract and validate pagination parameters from the query string.
* Applies default values and enforces security rules to prevent abuse.
* Returns a Pagination struct with the validated parameters.
 */
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

/*
* Axuliar function to format validation errors from the validator package into a more user-friendly structure.
* It checks if the error is of type ValidationErrors and extracts the field and the failed validation rule.
* If it's not a validation error, it returns a generic format error message.
 */
func FormatValidationError(err error) map[string]string {
	errMap := make(map[string]string)

	// For validation errors (binding tags: min, max, required, email, etc.))
	var valErrs validator.ValidationErrors
	if errors.As(err, &valErrs) {
		for _, e := range valErrs {
			errMap[e.Field()] = "Failed validation rule: " + e.Tag()
		}
		return errMap
	}

	// For type errors (ex: sent string instead of int)
	var unmarshalTypeError *json.UnmarshalTypeError
	if errors.As(err, &unmarshalTypeError) {
		errMap[unmarshalTypeError.Field] = "Invalid data type. Expected " + unmarshalTypeError.Type.String()
		return errMap
	}

	// For JSON syntax errors (e.g., malformed JSON)
	var syntaxError *json.SyntaxError
	if errors.As(err, &syntaxError) {
		errMap["format"] = "Malformed JSON syntax near byte offset " + strconv.FormatInt(syntaxError.Offset, 10)
		return errMap
	}

	// For empty request bodies (io.EOF)
	if errors.Is(err, io.EOF) {
		errMap["body"] = "Request body must not be empty"
		return errMap
	}

	// Fallback final: return the literal Go error message to ensure we never leave the user in the dark
	errMap["unknown_error"] = err.Error()
	return errMap
}
