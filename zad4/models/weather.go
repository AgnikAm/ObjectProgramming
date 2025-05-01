package models

import "gorm.io/gorm"

type Weather struct {
	gorm.Model
	City        string  `json:"city"`
	Temperature float64 `json:"temperature"`
	Humidity    int     `json:"humidity"`
	Pressure    int     `json:"pressure"`
	Description string  `json:"description"`
}
