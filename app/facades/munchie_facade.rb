class MunchieFacade
  def self.get_munchie(munchie_params)
    origin, destination, food = munchie_params[:start], munchie_params[:end], munchie_params[:food]
    route_response = GeocodingService.get_route(origin, destination)
    eta = Time.now.to_i + route_response[:route][:realTime]

    if route_response[:info][:statuscode].zero?
      lat, lng = route_response[:route][:locations].last[:latLng][:lat], route_response[:route][:locations].last[:latLng][:lng]
      forecast_response = WeatherService.get_weather(lat, lng)
      restaurant_response = RestaurantService.get_restaurant_by_city(destination, eta, food)

      Munchie.new(destination, route_response[:route][:realTime], forecast_response, restaurant_response)
    end
  end
end
