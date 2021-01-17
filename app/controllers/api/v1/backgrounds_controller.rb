class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageFacade.get_image(location_params)
    render json: ImageSerializer.new(image)
  end

  private
  def location_params
    params.permit(:location)
  end
end
