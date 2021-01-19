class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(weather_data)
    @datetime = Time.at(weather_data[:current][:dt]).to_s
    @sunrise = Time.at(weather_data[:current][:sunrise]).to_s
    @sunset = Time.at(weather_data[:current][:sunset]).to_s
    @temperature = weather_data[:current][:temp].to_f
    @feels_like = weather_data[:current][:feels_like].to_f
    @humidity = weather_data[:current][:humidity]
    @uvi = weather_data[:current][:uvi]
    @visibility = weather_data[:current][:visibility]
    @conditions = weather_data[:current][:weather].first[:description]
    @icon = weather_data[:current][:weather].first[:icon]
  end
end
