package database

import (
	"zad4/models"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var DB *gorm.DB

func InitDB() (*gorm.DB, error) {
	db, err := gorm.Open(sqlite.Open("weather.db"), &gorm.Config{})
	if err != nil {
		return nil, err
	}

	db.AutoMigrate(&models.Weather{})

	DB = db
	return db, nil
}
