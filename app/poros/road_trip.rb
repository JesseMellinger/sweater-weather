class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, *route_and_forecast_data)
    @id = nil
    @start_city = origin.gsub(',', ', ')
    @end_city = destination.gsub(',', ', ')
    @travel_time = set_travel_time(route_and_forecast_data)
    @weather_at_eta = set_weather_at_eta(route_and_forecast_data)
  end

  private
  def format_time(time)
    mm = time.divmod(60).first
    hh, mm = mm.divmod(60)
    hh = hh.divmod(24).last
    "%d hours, %d minutes" % [hh, mm]
  end

  def set_travel_time(route_and_forecast_data)
    return format_time(route_and_forecast_data.first[:route][:realTime]) if !route_and_forecast_data.empty?
    return "Impossible Route"
  end

  def set_weather_at_eta(route_and_forecast_data)
    return Weather.new(route_and_forecast_data.last, route_and_forecast_data.first[:route][:realTime]) if !route_and_forecast_data.empty?
    return {}
  end
end
