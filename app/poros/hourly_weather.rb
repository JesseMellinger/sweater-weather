class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon
              
  def initialize(hour_data)
    @time = Time.at(hour_data[:dt]).strftime("%T")
    @temperature = hour_data[:temp].to_f
    @wind_speed = hour_data[:wind_speed].to_s
    @wind_direction = get_direction(hour_data[:wind_deg])
    @conditions = hour_data[:weather].first[:description]
    @icon = hour_data[:weather].first[:icon]
  end

  private
  def get_direction(degrees)
    val = ((degrees/22.5) + 0.5).to_i
    directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    directions[(val % 16)]
  end
end
