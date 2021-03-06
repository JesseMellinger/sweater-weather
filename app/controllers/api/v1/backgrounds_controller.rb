class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageFacade.get_image(location_params)

    return render json: ImageSerializer.new(image) if image.instance_of? Image
    render json: image, status: :bad_request
  end

  private
  def location_params
    params.permit(:location)
  end
end
