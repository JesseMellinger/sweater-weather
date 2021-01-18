class Api::V1::UsersController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(payload)

    return render json: UserSerializer.new(user), status: :created if user.save
    return render json: {:message=>user.errors.full_messages}, status: :bad_request
  end
end
