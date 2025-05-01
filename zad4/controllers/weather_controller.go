package controllers

import (
	"net/http"
	"zad4/database"
	"zad4/models"
	"zad4/proxy"

	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
)

type WeatherController struct {
	DB    *gorm.DB
	Proxy proxy.WeatherProxy
}

func NewWeatherController(proxy proxy.WeatherProxy) *WeatherController {
	db, _ := database.InitDB()
	return &WeatherController{DB: db, Proxy: proxy}
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	city := c.QueryParam("city")
	if city == "" {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "City parameter is required"})
	}

	var weather models.Weather
	if err := wc.DB.Where("city = ?", city).First(&weather).Error; err == nil {
		return c.JSON(http.StatusOK, weather)
	}

	newWeather, err := wc.Proxy.GetWeather(city)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	wc.DB.Create(newWeather)

	return c.JSON(http.StatusOK, newWeather)
}

func (wc *WeatherController) GetMultipleWeather(c echo.Context) error {
	cities := c.QueryParams()["city"]
	if len(cities) == 0 {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "At least one city parameter is required"})
	}

	var results []models.Weather

	for _, city := range cities {
		var weather models.Weather
		if err := wc.DB.Where("city = ?", city).First(&weather).Error; err == nil {
			results = append(results, weather)
			continue
		}

		newWeather, err := wc.Proxy.GetWeather(city)
		if err != nil {
			continue
		}

		wc.DB.Create(newWeather)
		results = append(results, *newWeather)
	}

	return c.JSON(http.StatusOK, results)
}
