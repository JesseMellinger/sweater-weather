require 'rails_helper'

RSpec.describe MunchieFacade do
  describe 'class methods' do
    it '.get_munchie (happy path)', :vcr do
      munchie_params = {
                        :start=>"denver,co",
                        :end=>"pueblo,co",
                        :food=>"chinese"
                       }

      munchie = MunchieFacade.get_munchie(munchie_params)

      expect(munchie).to be_an(Munchie)

      expect(munchie.id).to be_nil

      expect(munchie.destination_city).to be_a(String)

      expect(munchie.forecast).to be_a(CurrentWeather)
      expect(munchie.forecast.summary).to be_a(String)
      expect(munchie.forecast.temperature).to be_a(String)

      expect(munchie.restaurant).to be_a(Restaurant)
      expect(munchie.restaurant.name).to be_a(String)
      expect(munchie.restaurant.address).to be_a(String)

      expect(munchie.travel_time).to be_a(String)
    end
  end
end
