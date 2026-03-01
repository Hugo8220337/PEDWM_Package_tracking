-- name: GetUserByID :one
SELECT id, created_at, name, email, password_hash, activated, version
FROM users
WHERE id = $1;

-- name: GetUserByEmail :one
SELECT id, created_at, name, email, password_hash, activated, version
FROM users
WHERE email = $1;

-- name: CreateUser :one
INSERT INTO users (
    name,
    email,
    password_hash,
    activated
) VALUES (
    $1,
    $2,
    $3,
    $4
)
RETURNING id, created_at, name, email, password_hash, activated, version;

-- name: ActivateUser :one
UPDATE users
SET activated = true,
    version = version + 1
WHERE id = $1
RETURNING id, created_at, name, email, password_hash, activated, version;
