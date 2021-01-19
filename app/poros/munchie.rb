class Munchie
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(destination, eta, forecast_response, restaurant_response)
    @id = nil
    @destination_city = format_destination_city(destination)
    @travel_time = format_time(eta)
    @forecast = format_forecast(forecast_response)
    @restaurant =  format_restaurant(restaurant_response)
  end

  private
  def format_destination_city(destination)
    destination = destination.split(',')
    city, state = destination.first.capitalize, destination.last.upcase
    "#{city}, #{state}"
  end

  def format_time(time)
    mm = time.divmod(60).first
    hh, mm = mm.divmod(60)
    hh = hh.divmod(24).last
    "%d hours, %d minutes" % [hh, mm]
  end

  def format_forecast(forecast_response)
    forecast = Hash.new
    forecast[:summary] = forecast_response[:current][:weather].first[:description]
    forecast[:temperature] = forecast_response[:current][:temp].to_s
    forecast
  end

  def format_restaurant(restaurant_response)
    restaurant = Hash.new
    restaurant[:name] = restaurant_response[:businesses].first[:name]
    restaurant[:address] = restaurant_response[:businesses].first[:location][:display_address].join(', ')
    restaurant
  end
end