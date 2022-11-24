package Routes

import (
	"QuestionBank/Authentication"

	"github.com/gofiber/fiber/v2"
)

func FiberRoutes(app *fiber.App) {
	app.Post("/RegisterUser", Authentication.RegisterUser)
	app.Post("/Login", Authentication.Login)
	app.Get("/ReturnUser", Authentication.ReturnUserName)
}
