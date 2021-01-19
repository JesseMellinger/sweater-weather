class Api::V1::MunchiesController < ApplicationController
  def index
    munchie = MunchieFacade.get_munchie(munchie_params)
    render json: MunchieSerializer.new(munchie)
  end

  private
  def munchie_params
    params.permit(:start, :end, :food)
  end
end
