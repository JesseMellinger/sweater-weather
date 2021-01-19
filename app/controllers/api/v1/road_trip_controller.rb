class Api::V1::RoadTripController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: payload[:api_key])

    if user
      trip = RoadTripFacade.get_trip(payload[:origin], payload[:destination])
      return render json: RoadTripSerializer.new(trip)
    else
      render json: {message: "Invalid API key"}, status: :unauthorized
    end
  end
end
