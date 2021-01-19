require 'rails_helper'

describe 'munchies' do
  it 'returns munchies data that includes id, type, and attributes (happy path)', :vcr do
    location_and_food_params = {
      'start': 'denver,co',
      'end': 'pueblo,co',
      'food': 'chinese'
    }

    get '/api/v1/munchies', params: location_and_food_params

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(endpoint_response).to be_a(Hash)

    expect(endpoint_response).to have_key(:data)
    expect(endpoint_response[:data]).to be_a(Hash)
    expect(endpoint_response[:data][:id]).to be_nil

    expect(endpoint_response[:data]).to have_key(:type)
    expect(endpoint_response[:data][:type]).to be_a(String)

    expect(endpoint_response[:data]).to have_key(:attributes)
    expect(endpoint_response[:data][:attributes]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes]).to have_key(:destination_city)
    expect(endpoint_response[:data][:attributes][:destination_city]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:travel_time)
    expect(endpoint_response[:data][:attributes][:travel_time]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:forecast)
    expect(endpoint_response[:data][:attributes][:forecast]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes][:forecast]).to have_key(:summary)
    expect(endpoint_response[:data][:attributes][:forecast][:summary]).to be_a(String)

    expect(endpoint_response[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(endpoint_response[:data][:attributes][:forecast][:temperature]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:restaurant)
    expect(endpoint_response[:data][:attributes][:restaurant]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes][:restaurant]).to have_key(:name)
    expect(endpoint_response[:data][:attributes][:restaurant][:name]).to be_a(String)

    expect(endpoint_response[:data][:attributes][:restaurant]).to have_key(:address)
    expect(endpoint_response[:data][:attributes][:restaurant][:address]).to be_a(String)
  end
end
