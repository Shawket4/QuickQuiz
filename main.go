package main

import (
	"QuestionBank/Config"
	"QuestionBank/Database"
)

func main() {
	Database.GormConnect()
	Config.FiberConfig()
}
