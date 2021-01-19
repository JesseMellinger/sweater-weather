class Munchie
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :restaurant

  def initialize(destination, time, forecast_response, restaurant_response)
    @id = nil
    @destination_city = format_destination_city(destination)
    @travel_time = format_time(time)
    @forecast = get_current_weather(forecast_response)
    @restaurant =  get_restaurant(restaurant_response)
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

  def get_current_weather(forecast_response)
    CurrentWeather.new(forecast_response)
  end

  def get_restaurant(restaurant_response)
    Restaurant.new(restaurant_response)
  end
end
