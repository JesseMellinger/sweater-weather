class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(weather_data)
    @id = nil
    @current_weather = get_current_weather(weather_data)
    @daily_weather = get_daily_weather(weather_data)
    @hourly_weather = get_hourly_weather(weather_data)
  end

  private
  def get_current_weather(weather_data)
    CurrentWeather.new(weather_data)
  end

  def get_daily_weather(weather_data)
    daily_weather = weather_data[:daily].first(5).map do |day_data|
      DailyWeather.new(day_data)
    end
    daily_weather
  end

  def get_hourly_weather(weather_data)
    hourly_weather = weather_data[:hourly].first(8).map do |hour_data|
      HourlyWeather.new(hour_data)
    end
    hourly_weather
  end
end
