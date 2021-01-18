class Api::V1::SessionsController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: payload[:email]).try(:authenticate, payload[:password])

    return render json: UserSerializer.new(user), status: :ok if user
    return render json: {:message=>"Authentication failed"}, status: :bad_request
  end
end
