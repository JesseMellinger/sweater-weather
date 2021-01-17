class WeatherService
  def self.get_weather(lat, lng)
    response = conn.get do |req|
      req.params['lat'] = lat
      req.params['lon'] = lng
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
      req.params['appid'] = ENV['OPENWEATHER_API_KEY']
    end
    parse_response(response)
  end

  private
  def self.conn
    Faraday.new('https://api.openweathermap.org/data/2.5/onecall')
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
