class ForecastFacade
  def self.get_forecast(location)
    location_response = GeocodingService.get_geocode_address(location)
    lat, lng = location_response[:results].first[:locations].first[:latLng][:lat], location_response[:results].first[:locations].first[:latLng][:lng]
    forecast_response = WeatherService.get_weather(lat, lng)
    Forecast.new(forecast_response)
  end
end
