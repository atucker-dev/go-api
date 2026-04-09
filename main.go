package main

import (
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func main() {
	app := fiber.New()
	app.Use(cors.New())

	api := app.Group("/api")

	// Health check endpoint
	api.Get("/",
		func(c *fiber.Ctx) error {
			return c.JSON(fiber.Map{"status": "running"})
		})

	certFile := os.Getenv("TLS_CERT")
	keyFile := os.Getenv("TLS_KEY")

	if certFile != "" && keyFile != "" {
		log.Fatal(app.ListenTLS(":3001", certFile, keyFile))
	} else {
		log.Fatal(app.Listen(":3001"))
	}
}
