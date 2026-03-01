-- name: GetMovie :one
SELECT id, created_at, title, year, runtime, genres, version
FROM movies
WHERE id = $1;

-- name: ListMovies :many
SELECT id, created_at, title, year, runtime, genres, version
FROM movies
ORDER BY id
LIMIT $1 OFFSET $2;

-- name: CreateMovie :one
INSERT INTO movies (
    title,
    year,
    runtime,
    genres
) VALUES (
    $1,
    $2,
    $3,
    $4
)
RETURNING id, created_at, title, year, runtime, genres, version;

-- name: UpdateMovie :one
UPDATE movies
SET title = $2,
    year = $3,
    runtime = $4,
    genres = $5,
    version = version + 1
WHERE id = $1
RETURNING id, created_at, title, year, runtime, genres, version;

-- name: DeleteMovie :exec
DELETE FROM movies
WHERE id = $1;
