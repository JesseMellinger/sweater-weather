class RestaurantService
  def self.get_restaurant_by_city(destination, eta, food)
    response = conn.get 'businesses/search' do |req|
      req.params['location'] = destination
      req.params['limit'] = 1
      req.params['open_at'] = eta
      req.params['term'] = food
    end
    parse_response(response)
  end

  private
  def self.conn
    Faraday.new('https://api.yelp.com/v3/') do |conn|
      conn.authorization :Bearer, ENV.fetch('YELP_API_KEY')
      conn.request :url_encoded
      conn.adapter Faraday.default_adapter
    end
  end

  def self.parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
