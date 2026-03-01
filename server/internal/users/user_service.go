package users

import (
	db "basicAPI/db/sqlc"
	"context"
)

type DbConnection struct {
	Query *db.Queries
}

type UserService interface {
	CreateUser(ctx context.Context, name string, email string) (db.User, error)
}

type CreateUserInput struct {
	Name  string
	Email string
}

func (conn DbConnection) CreateUser(ctx context.Context, name string, email string) (db.User, error) {
	return conn.Query.CreateUser(ctx, db.CreateUserParams{
		Name:  name,
		Email: email,
	})
}
