package Config

import (
	"QuestionBank/Routes"

	"github.com/gofiber/fiber/v2"
)

func FiberConfig() {
	app := fiber.New()
	Routes.FiberRoutes(app)
	app.Listen(":6666")
}
