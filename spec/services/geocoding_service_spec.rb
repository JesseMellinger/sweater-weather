require 'rails_helper'

RSpec.describe 'GeocodingService' do
  it 'should return parsed response data (happy path)', :vcr  do
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

  it 'should return an error message when bad params are passed (sad path)', :vcr do
    location_params = {
      'location' => ''
    }

    response_data = GeocodingService.get_geocode_address(location_params)

    expect(response_data[:info][:statuscode]).to eq(400)
    expect(response_data[:info][:messages].first).to eq("Illegal argument from request: Insufficient info for location")
    expect(response_data[:results].first[:providedLocation][:location]).to eq("")
    expect(response_data[:results].first[:providedLocation][:locations]).to be_nil
  end
end
