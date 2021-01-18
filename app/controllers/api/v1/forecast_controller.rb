class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.get_forecast(location_params)

    return render json: ForecastSerializer.new(forecast) if forecast.instance_of? Forecast
    render json: {:status_code=>forecast[:info][:statuscode],
                  :message=>forecast[:info][:messages].first}
  end

  private
  def location_params
    params.permit(:location)
  end
end
