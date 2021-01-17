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
    current_weather = Hash.new
    current_weather[:datetime] = Time.at(weather_data[:current][:dt]).to_s
    current_weather[:sunrise] = Time.at(weather_data[:current][:sunrise]).to_s
    current_weather[:sunset] = Time.at(weather_data[:current][:sunset]).to_s
    current_weather[:temperature] = weather_data[:current][:temp].to_f
    current_weather[:feels_like] = weather_data[:current][:feels_like].to_f
    current_weather[:humidity] = weather_data[:current][:humidity]
    current_weather[:uvi] = weather_data[:current][:uvi]
    current_weather[:visibility] = weather_data[:current][:visibility]
    current_weather[:conditions] = weather_data[:current][:weather].first[:description]
    current_weather[:icon] = weather_data[:current][:weather].first[:icon]
    current_weather
  end

  def get_daily_weather(weather_data)
    daily_weather = weather_data[:daily].first(5).map do |day_data|
      day = Hash.new
      day[:date] = Time.at(day_data[:dt]).strftime("%F")
      day[:sunrise] = Time.at(day_data[:sunrise]).to_s
      day[:sunset] = Time.at(day_data[:sunset]).to_s
      day[:max_temp] = day_data[:temp][:max]
      day[:min_temp] = day_data[:temp][:min]
      day[:conditions] = day_data[:weather].first[:description]
      day[:icon] = day_data[:weather].first[:icon]
      day
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
