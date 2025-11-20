// Go Demo File
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"
)

// Constants
const (
	APIURL     = "https://api.example.com"
	MaxRetries = 3
	Timeout    = 5 * time.Second
)

// Structs
type User struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	Role      string    `json:"role"`
	CreatedAt time.Time `json:"created_at"`
}

type APIResponse struct {
	Data    interface{} `json:"data"`
	Status  int         `json:"status"`
	Message string      `json:"message"`
}

// Methods
func (u *User) GetDisplayName() string {
	return fmt.Sprintf("%s <%s>", u.Name, u.Email)
}

func (u *User) IsAdmin() bool {
	return u.Role == "admin"
}

// Interfaces
type Repository interface {
	FindByID(id int) (*User, error)
	FindAll() ([]*User, error)
	Create(user *User) error
}

type UserRepository struct {
	users []*User
}

func (r *UserRepository) FindByID(id int) (*User, error) {
	for _, user := range r.users {
		if user.ID == id {
			return user, nil
		}
	}
	return nil, fmt.Errorf("user not found: %d", id)
}

func (r *UserRepository) FindAll() ([]*User, error) {
	return r.users, nil
}

func (r *UserRepository) Create(user *User) error {
	r.users = append(r.users, user)
	return nil
}

// Functions
func greetUser(name string) string {
	return fmt.Sprintf("Hello, %s!", name)
}

func calculateTotal(items []float64) float64 {
	var total float64
	for _, item := range items {
		total += item
	}
	return total
}

// Error handling
func fetchUserData(userID int) (*User, error) {
	ctx, cancel := context.WithTimeout(context.Background(), Timeout)
	defer cancel()

	url := fmt.Sprintf("%s/users/%d", APIURL, userID)
	req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	client := &http.Client{Timeout: Timeout}
	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to fetch user: %w", err)
	}
	defer resp.Body.Close()

	var user User
	if err := json.NewDecoder(resp.Body).Decode(&user); err != nil {
		return nil, fmt.Errorf("failed to decode response: %w", err)
	}

	return &user, nil
}

// Goroutines and channels
func processUsers(users []*User, results chan<- string) {
	for _, user := range users {
		go func(u *User) {
			results <- fmt.Sprintf("Processed: %s", u.Name)
		}(user)
	}
}

// Generics (Go 1.18+)
func find[T comparable](slice []T, value T) (int, bool) {
	for i, v := range slice {
		if v == value {
			return i, true
		}
	}
	return -1, false
}

// Type assertions and type switches
func processValue(value interface{}) string {
	switch v := value.(type) {
	case string:
		return fmt.Sprintf("String: %s", v)
	case int:
		return fmt.Sprintf("Integer: %d", v)
	case *User:
		return fmt.Sprintf("User: %s", v.Name)
	default:
		return fmt.Sprintf("Unknown type: %T", v)
	}
}

// Defer, panic, recover
func safeOperation() {
	defer func() {
		if r := recover(); r != nil {
			log.Printf("Recovered from panic: %v", r)
		}
	}()

	// Some operation that might panic
	panic("something went wrong")
}

// Main function
func main() {
	users := []*User{
		{ID: 1, Name: "Alice", Email: "alice@example.com", Role: "admin"},
		{ID: 2, Name: "Bob", Email: "bob@example.com", Role: "user"},
		{ID: 3, Name: "Charlie", Email: "charlie@example.com", Role: "moderator"},
	}

	repo := &UserRepository{users: users}

	user, err := repo.FindByID(1)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(greetUser(user.Name))
	fmt.Printf("Display name: %s\n", user.GetDisplayName())
	fmt.Printf("Is admin: %v\n", user.IsAdmin())

	// Using generics
	numbers := []int{1, 2, 3, 4, 5}
	index, found := find(numbers, 3)
	if found {
		fmt.Printf("Found at index: %d\n", index)
	}
}

