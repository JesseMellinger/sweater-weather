require 'rails_helper'

RSpec.describe 'ImageService', :vcr do
  it 'should return parsed response data' do
    location_params = {
      'location' => 'denver,co'
    }

    response = ImageService.get_image_by_location(location_params)
    
    expect(response).to be_a(Hash)

    expect(response).to have_key(:photos)
    expect(response[:photos]).to be_a(Hash)

    expect(response[:photos]).to have_key(:perpage)
    expect(response[:photos][:perpage]).to eq(1)

    expect(response[:photos]).to have_key(:photo)
    expect(response[:photos][:photo]).to be_an(Array)
    expect(response[:photos][:photo].count).to eq(1)

    expect(response[:photos][:photo].first).to have_key(:url_l)
    expect(response[:photos][:photo].first[:url_l]).to be_a(String)

    expect(response[:photos][:photo].first).to_not have_key(:iconfarm)
    expect(response[:photos][:photo].first).to_not have_key(:iconserver)
  end
end
