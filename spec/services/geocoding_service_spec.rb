require 'rails_helper'

RSpec.describe 'GeocodingService' do
  describe 'class methods' do
    it '.get_geocode_address (happy path)', :vcr  do
      location_params = {
        'location' => 'denver,co'
      }
      response = GeocodingService.get_geocode_address(location_params)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:info)
      expect(response[:info]).to be_a(Hash)

      expect(response).to have_key(:options)
      expect(response[:options]).to be_a(Hash)

      expect(response).to have_key(:results)
      expect(response[:results]).to be_an(Array)
      expect(response[:results].first).to have_key(:providedLocation)
      expect(response[:results].first[:providedLocation]).to have_key(:location)
      expect(response[:results].first[:providedLocation][:location]).to eq(location_params['location'])
      expect(response[:results].first).to have_key(:locations)
      expect(response[:results].first[:locations].first).to have_key(:latLng)
      expect(response[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lat)
      expect(response[:results].first[:locations].first[:latLng]).to have_key(:lng)
    end

    it '.get_geocode_address (sad path)', :vcr do
      location_params = {
        'location' => ''
      }

      response_data = GeocodingService.get_geocode_address(location_params)

      expect(response_data[:info][:statuscode]).to eq(400)
      expect(response_data[:info][:messages].first).to eq("Illegal argument from request: Insufficient info for location")
      expect(response_data[:results].first[:providedLocation][:location]).to eq("")
      expect(response_data[:results].first[:providedLocation][:locations]).to be_nil
    end

    it '.get_route (happy path)', :vcr do
      origin, destination = "Denver,CO", "Pueblo,CO"

      response = GeocodingService.get_route(origin, destination)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:route)
      expect(response[:route]).to be_a(Hash)

      expect(response).to have_key(:info)
      expect(response[:info]).to be_a(Hash)

      expect(response[:info]).to have_key(:statuscode)
      expect(response[:info][:statuscode]).to eq(0)

      expect(response[:route]).to have_key(:realTime)
      expect(response[:route][:realTime]).to be_an(Integer)

      expect(response[:route]).to have_key(:locations)
      expect(response[:route][:locations]).to be_an(Array)
      expect(response[:route][:locations].count).to eq(2)

      expect(response[:route][:locations].last).to be_a(Hash)
      expect(response[:route][:locations].last).to have_key(:latLng)
      expect(response[:route][:locations].last[:latLng]).to be_a(Hash)
      expect(response[:route][:locations].last[:latLng]).to have_key(:lng)
      expect(response[:route][:locations].last[:latLng][:lng]).to be_a(Float)
      expect(response[:route][:locations].last[:latLng]).to have_key(:lat)
      expect(response[:route][:locations].last[:latLng][:lat]).to be_a(Float)
    end

    it '.get_route (sad path)', :vcr do
      origin, destination = "New York, NY", "London, UK"

      response = GeocodingService.get_route(origin, destination)

      expect(response).to be_a(Hash)

      expect(response).to have_key(:info)
      expect(response[:info]).to be_a(Hash)

      expect(response[:info]).to have_key(:statuscode)
      expect(response[:info][:statuscode]).to eq(402)

      expect(response[:info]).to have_key(:messages)
      expect(response[:info][:messages]).to be_an(Array)
      expect(response[:info][:messages].first).to eq("We are unable to route with the given locations.")
    end
  end
end
