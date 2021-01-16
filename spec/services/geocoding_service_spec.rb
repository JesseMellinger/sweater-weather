require 'rails_helper'

RSpec.describe 'GeocodingService', :vcr do
  it 'should return parsed response data' do
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
end
