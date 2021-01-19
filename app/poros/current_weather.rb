class CurrentWeather
  attr_reader :summary,
              :temperature

  def initialize(forecast_response)
    @summary = forecast_response[:current][:weather].first[:description]
    @temperature = forecast_response[:current][:temp].to_s
  end
end
