package users

import (
	db "basicAPI/db/sqlc"
	"context"
)

type UserHandler struct {
	Service UserService
}

func (h UserHandler) CreateUser(ctx context.Context, name string, email string) (db.User, error) {
	return h.Service.CreateUser(ctx, name, email)
}
