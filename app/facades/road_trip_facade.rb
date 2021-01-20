class RoadTripFacade
  def self.get_trip(origin, destination)
    route_response = GeocodingService.get_route(origin, destination)

    if route_response[:info][:statuscode].zero?
      lat, lng = route_response[:route][:locations].last[:latLng][:lat], route_response[:route][:locations].last[:latLng][:lng]
      forecast_response = Rails.cache.fetch([lat, lng], expires_in: 12.hours) do
        WeatherService.get_weather(lat, lng)
      end
      return RoadTrip.new(origin, destination, route_response, forecast_response)
    else
      RoadTrip.new(origin, destination)
    end
  end
end
