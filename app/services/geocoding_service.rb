class GeocodingService
  def self.get_geocode_address(location)
    response = conn.get '/geocoding/v1/address' do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
      req.params['location'] = location['location']
    end
    parse_response(response)
  end

  def self.get_route(origin, destination)
    response = conn.get '/directions/v2/route' do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
    end
    parse_response(response)
  end

  private
  def self.conn
    Faraday.new('http://www.mapquestapi.com')
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
