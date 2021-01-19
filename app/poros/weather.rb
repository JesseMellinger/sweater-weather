class Weather
  attr_reader :temperature,
              :conditions

  def initialize(forecast_data, travel_time)
    @temperature, @conditions = get_eta_temperature(forecast_data, travel_time)
  end

  private
  def get_eta_temperature(forecast_data, travel_time)
    eta = Time.now.to_i + travel_time
    hours = forecast_data[:hourly].group_by { |hour| hour[:dt] <=> eta }
    hour = hours[0] ? hours[0].first : hours[-1].last
    return hour[:temp], hour[:weather].first[:description]
  end
end
