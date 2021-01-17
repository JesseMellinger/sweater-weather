class GeocodingService
  def self.get_geocode_address(location)
    response = conn.get do |req|
      req.params['key'] = ENV['MAPQUEST_API_KEY']
      req.params['location'] = location['location']
    end
    parse_response(response)
  end

  private
  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/address')
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
