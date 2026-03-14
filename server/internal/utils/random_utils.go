package utils

import "math/rand"

type RandomUtils struct {
}

func (r *RandomUtils) RandomString(n int) string {
	const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	result := make([]byte, n)
	for i := range result {
		random_number := rand.Intn(len(letters))
		result[i] = letters[random_number]
	}
	return string(result)
}
