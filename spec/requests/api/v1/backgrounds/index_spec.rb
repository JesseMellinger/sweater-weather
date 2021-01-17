require 'rails_helper'

describe 'backgrounds' do
  it 'it returns background image data that includes id, type, and attributes', :vcr do
    location_params = {
      location: 'denver,co'
    }

    get '/api/v1/backgrounds', params: location_params

    image = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful

    expect(image).to be_a(Hash)

    expect(image).to have_key(:data)
    expect(image[:data]).to be_a(Hash)
    expect(image[:data][:id]).to be_nil

    expect(image[:data]).to have_key(:type)
    expect(image[:data][:type]).to be_a(String)

    expect(image[:data]).to have_key(:attributes)
    expect(image[:data][:attributes]).to be_a(Hash)

    expect(image[:data][:attributes]).to have_key(:image)
    expect(image[:data][:attributes][:image]).to be_a(Hash)

    expect(image[:data][:attributes][:image]).to have_key(:location)
    expect(image[:data][:attributes][:image][:location]).to be_a(String)

    expect(image[:data][:attributes][:image]).to have_key(:image_url)
    expect(image[:data][:attributes][:image][:image_url]).to be_a(String)

    expect(image[:data][:attributes][:image]).to have_key(:attribution)
    expect(image[:data][:attributes][:image][:attribution]).to be_a(Hash)

    expect(image[:data][:attributes][:image][:attribution]).to have_key(:message)
    expect(image[:data][:attributes][:image][:attribution][:message]).to be_a(String)
  end
end
