class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(day_data)
    @date = Time.at(day_data[:dt]).strftime("%F")
    @sunrise = Time.at(day_data[:sunrise]).to_s
    @sunset = Time.at(day_data[:sunset]).to_s
    @max_temp = day_data[:temp][:max]
    @min_temp = day_data[:temp][:min]
    @conditions = day_data[:weather].first[:description]
    @icon = day_data[:weather].first[:icon]
  end
  
end
