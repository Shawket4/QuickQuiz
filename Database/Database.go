package Database

import (
	"QuestionBank/Models"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DB *gorm.DB

func GormConnect() {
	connection, err := gorm.Open(mysql.Open("snap:Snapsnap@2@tcp(92.205.60.182:3306)/QuickQuiz"), &gorm.Config{})

	if err != nil {
		panic("Could not connect to the database")
	}
	DB = connection
	connection.AutoMigrate(&Models.User{})
}
