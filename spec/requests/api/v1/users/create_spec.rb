require 'rails_helper'

describe 'users' do
  it 'returns a successful response with type, id, attribute keys (happy path)' do
    payload = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
              }

    post '/api/v1/users', params: payload.to_json

    expect(response).to be_successful
    expect(response.status).to eq(201)

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

  it 'returns a 400 status code with a description of why the request wasn’t successful when passwords dont\'t match (sad path)' do
    payload = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "123"
              }

    post '/api/v1/users', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message].first).to eq("Password confirmation doesn't match Password")
  end

  it 'returns a 400 status code with a description of why the request wasn’t successful when email already taken (sad path)' do
    email = "whatever@example.com"
    password = "123"
    password_confirmation = "123"

    User.create!(email: email, password: password, password_confirmation: password_confirmation)

    payload = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
              }

    post '/api/v1/users', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message].first).to eq("Email has already been taken")
  end

  it 'returns a 400 status code with a description of why the request wasn’t successful when missing a field (sad path)' do
    payload = {
                "email": "",
                "password": "password",
                "password_confirmation": "password"
              }

    post '/api/v1/users', params: payload.to_json

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    endpoint_response = JSON.parse(response.body, symbolize_names: true)

    expect(endpoint_response).to be_a(Hash)
    expect(endpoint_response).to have_key(:message)
    expect(endpoint_response[:message].first).to eq("Email can't be blank")
    expect(endpoint_response[:message].second).to eq("Email is invalid")
  end
end
