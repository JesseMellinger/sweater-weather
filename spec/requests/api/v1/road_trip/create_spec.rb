require 'rails_helper'

describe 'road trip' do
  before :each do
    payload = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
              }

    @user = User.create!(payload)
  end
  it 'returns a successful response with type, id, attribute keys (happy path)', :vcr do
    payload = {
                "origin": "Denver,CO",
                "destination": "Pueblo,CO",
                "api_key": @user.api_key
              }

    post '/api/v1/road_trip', params: payload.to_json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:data)
    expect(endpoint_response[:data]).to be_a(Hash)

    expect(endpoint_response[:data]).to have_key(:id)
    expect(endpoint_response[:data][:id]).to be_nil

    expect(endpoint_response[:data]).to have_key(:type)
    expect(endpoint_response[:data][:type]).to be_a(String)

    expect(endpoint_response[:data]).to have_key(:attributes)
    expect(endpoint_response[:data][:attributes]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes]).to have_key(:start_city)
    expect(endpoint_response[:data][:attributes][:start_city]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:end_city)
    expect(endpoint_response[:data][:attributes][:end_city]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:travel_time)
    expect(endpoint_response[:data][:attributes][:travel_time]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:weather_at_eta)
    expect(endpoint_response[:data][:attributes][:weather_at_eta]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(endpoint_response[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

    expect(endpoint_response[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(endpoint_response[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'returns error response with 401 status code if api key is not given or is incorrect (sad path)' do
    payload = {
                "origin": "Denver,CO",
                "destination": "Pueblo,CO",
                "api_key": ''
              }

    post '/api/v1/road_trip', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message]).to eq("Invalid API key")
  end
end
