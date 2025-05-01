package proxy

import (
	"encoding/json"
	"io"
	"net/http"
	"zad4/models"
)

type WeatherProxy interface {
	GetWeather(city string) (*models.Weather, error)
}

type OpenWeatherProxy struct {
	APIKey string
}

func NewOpenWeatherProxy(apiKey string) *OpenWeatherProxy {
	return &OpenWeatherProxy{APIKey: apiKey}
}

func (p *OpenWeatherProxy) GetWeather(city string) (*models.Weather, error) {
	url := "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + p.APIKey + "&units=metric"

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var result map[string]interface{}
	json.Unmarshal(body, &result)

	weather := &models.Weather{
		City:        city,
		Temperature: result["main"].(map[string]interface{})["temp"].(float64),
		Humidity:    int(result["main"].(map[string]interface{})["humidity"].(float64)),
		Pressure:    int(result["main"].(map[string]interface{})["pressure"].(float64)),
		Description: result["weather"].([]interface{})[0].(map[string]interface{})["description"].(string),
	}

	return weather, nil
}
