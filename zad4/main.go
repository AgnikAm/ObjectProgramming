package main

import (
	"zad4/controllers"
	"zad4/database"
	"zad4/proxy"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	_, err := database.InitDB()
	if err != nil {
		panic("Failed to connect to database")
	}

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	weatherProxy := proxy.NewOpenWeatherProxy("API_KEY")

	weatherController := controllers.NewWeatherController(weatherProxy)

	e.GET("/weather", weatherController.GetWeather)
	e.GET("/weather/multiple", weatherController.GetMultipleWeather)

	e.Logger.Fatal(e.Start(":8080"))
}
