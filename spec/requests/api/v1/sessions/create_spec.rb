require 'rails_helper'

describe 'sessions' do
  before :each do
    payload = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
              }

    @user = User.create!(payload)
  end
  it 'returns a successful response with type, id, attribute keys (happy path)' do
    payload = {
                "email": "whatever@example.com",
                "password": "password"
              }

    post '/api/v1/sessions', params: payload.to_json

    expect(response).to be_successful
    expect(response.status).to eq(200)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:data)
    expect(endpoint_response[:data]).to be_a(Hash)

    expect(endpoint_response[:data]).to have_key(:type)
    expect(endpoint_response[:data][:type]).to be_a(String)

    expect(endpoint_response[:data]).to have_key(:id)
    expect(endpoint_response[:data][:id]).to be_a(String)

    expect(endpoint_response[:data]).to have_key(:attributes)
    expect(endpoint_response[:data][:attributes]).to be_a(Hash)

    expect(endpoint_response[:data][:attributes]).to have_key(:email)
    expect(endpoint_response[:data][:attributes][:email]).to be_a(String)

    expect(endpoint_response[:data][:attributes]).to have_key(:api_key)
    expect(endpoint_response[:data][:attributes][:api_key]).to be_a(String)
  end

  it 'returns a 400 status code with a description that authentication failed when credentials are bad (sad path)' do
    payload = {
                "email": "whatever@example.com",
                "password": "123"
              }

    post '/api/v1/sessions', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message]).to eq("Authentication failed")
  end

  it 'returns a 400 status code with a description that authentication failed when field is blank (sad path)' do
    payload = {
                "email": "",
                "password": "123"
              }

    post '/api/v1/sessions', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message]).to eq("Authentication failed")
  end
end
