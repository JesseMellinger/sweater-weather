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
      hour = Hash.new
      hour[:time] = Time.at(hour_data[:dt]).strftime("%T")
      hour[:temperature] = hour_data[:temp].to_f
      hour[:wind_speed] = hour_data[:wind_speed].to_s
      hour[:wind_direction] = get_direction(hour_data[:wind_deg])
      hour[:conditions] = hour_data[:weather].first[:description]
      hour[:icon] = hour_data[:weather].first[:icon]
      hour
    end
    hourly_weather
  end

  def get_direction(degrees)
    val = ((degrees/22.5) + 0.5).to_i
    directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    directions[(val % 16)]
  end
end
