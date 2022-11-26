package Authentication

import (
	"QuestionBank/Database"
	"QuestionBank/Models"
	"fmt"
	"log"
	"strconv"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
)

const SecretKey = "secret"

func RegisterUser(c *fiber.Ctx) error {
	var data map[string]string
	err := c.BodyParser(&data)
	if err != nil {
		log.Println(err)
	}
	var User Models.User
	password, _ := bcrypt.GenerateFromPassword([]byte(data["password"]), 14)
	User.Email = data["email"]
	User.Password = password
	User.Name = data["name"]
	User.Permission, err = strconv.Atoi(data["permission"])
	if err != nil {
		log.Println(err)
		return c.JSON(fiber.Map{
			"Message": "An Error Has Occurred",
		})
	}
	Database.DB.Create(&User)
	return c.JSON(fiber.Map{
		"Message": "User Created Successfully",
	})
}

func User(c *fiber.Ctx) (Models.User, error) {
	var User Models.User
	cookie := c.Cookies("jwt")

	token, err := jwt.ParseWithClaims(cookie, &jwt.RegisteredClaims{}, func(t *jwt.Token) (interface{}, error) {
		return []byte(SecretKey), nil
	})

	if err != nil {
		c.Status(fiber.StatusUnauthorized)
		fmt.Println("Error", err)
		return Models.User{}, err
	}

	claims := token.Claims.(*jwt.RegisteredClaims)

	Database.DB.Where("id = ?", claims.Issuer).First(&User)
	return User, nil
}

func Login(c *fiber.Ctx) error {
	var data map[string]string

	if err := c.BodyParser(&data); err != nil {
		return c.JSON(fiber.Map{
			"message": err.Error(),
		})
	}

	var User Models.User
	Database.DB.Where("email = ?", data["email"]).First(&User)
	if User.Id == 0 {

		return c.JSON(fiber.Map{
			"message": "Email not found",
		})
	}
	err := bcrypt.CompareHashAndPassword(User.Password, []byte(data["password"]))

	if err != nil {

		return c.JSON(fiber.Map{
			"message": "Invalid password",
		})
	}
	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.RegisteredClaims{
		Issuer:    strconv.Itoa(int(User.Id)),
		ExpiresAt: jwt.NewNumericDate(time.Unix(time.Now().Add(time.Hour*24*2).Unix(), 0)), // 2 day
	})

	token, err := claims.SignedString([]byte(SecretKey))

	cookie := fiber.Cookie{
		Name:     "jwt",
		Value:    token,
		Expires:  time.Now().Add(time.Hour * 24 * 2),
		HTTPOnly: true,
	}

	c.Cookie(&cookie)
	if err != nil {
		return c.JSON(fiber.Map{
			"message": "could not login",
		})
	}
	return c.JSON(fiber.Map{
		"jwt":        token,
		"message":    "Login Successful",
		"permission": User.Permission,
	})
}

func ReturnUserName(c *fiber.Ctx) error {
	user, err := User(c)
	if err != nil {
		log.Println(err)
		return c.JSON(fiber.Map{})
	}
	return c.JSON(user)
}
