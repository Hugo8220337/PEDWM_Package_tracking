package main

import (
	"basicAPI/internal/handlers"

	"github.com/gin-gonic/gin"
)

func setupRouter(h *handlers.Container) *gin.Engine {
	// Create a new router using the httprouter package
	r := gin.Default()

	// Convert the notFoundResponse() helper to a http.Handler using the
	// http.HandlerFunc() adapter, and then set it as the custom error handler for 404
	// Not Found responses.
	// router.NotFound = http.HandlerFunc(h.UserZ.notFoundResponse)

	// // Likewise, convert the methodNotAllowedResponse() helper to a http.Handler and set
	// // it as the custom error handler for 405 Method Not Allowed responses.
	// router.MethodNotAllowed = http.HandlerFunc(app.methodNotAllowedResponse)

	/**
	 * Register the API endpoints and their corresponding handler functions.
	 * The HandlerFunc() method is used to associate an HTTP method and a URL pattern with a handler function.
	 * For example, the first line registers a handler for GET requests to the /v1/healthcheck endpoint, which will be handled by the app.healthcheckHandler function.
	 */
	// router.HandlerFunc(http.MethodGet, "/v1/healthcheck", app.healthcheckHandler)
	// router.HandlerFunc(http.MethodPost, "/v1/movies", app.createMovieHandler)
	// router.HandlerFunc(http.MethodGet, "/v1/movies/:id", app.showMovieHandler)
	// router.HandlerFunc(http.MethodPut, "/v1/movies/:id", app.updateMovieHandler)
	// router.HandlerFunc(http.MethodDelete, "/v1/movies/:id", app.deleteMovieHandler)

	r.POST("/v1/users", h.User.CreateUser)

	return r
}
