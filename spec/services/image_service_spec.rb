require 'rails_helper'

RSpec.describe 'ImageService' do
  it 'should return parsed response data (happy path)', :vcr do
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

  it 'should return an error message when bad params are passed (sad path)', :vcr do
    location_params = {
      'location' => ''
    }

    response_data = ImageService.get_image_by_location(location_params)

    expect(response_data).to be_a(Hash)
    expect(response_data).to have_key(:stat)
    expect(response_data[:stat]).to eq("fail")

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Parameterless searches have been disabled. Please use flickr.photos.getRecent instead.")
  end
end
