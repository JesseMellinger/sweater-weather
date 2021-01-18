class Api::V1::UsersController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(payload)
    if user.save
      return render json: UserSerializer.new(user), status: :created
    else
      return render json: {:status=>400, :message=>user.errors.full_messages}
    end
  end
end