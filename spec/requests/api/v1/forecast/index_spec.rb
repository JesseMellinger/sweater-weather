require 'rails_helper'

describe 'forecast' do
  it 'returns forecast data that includes id, type, and attributes (happy path)', :vcr do
    location_params = {
      'location': 'denver,co'
    }

    get '/api/v1/forecast', params: location_params

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(forecast).to be_a(Hash)

    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to be_a(Hash)
    expect(forecast[:data][:id]).to be_nil

    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to be_a(String)

    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)

    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
    expect(forecast[:data][:attributes][:current_weather][:datetime]).to be_a(String)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunrise)
    expect(forecast[:data][:attributes][:current_weather][:sunrise]).to be_a(String)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunset)
    expect(forecast[:data][:attributes][:current_weather][:sunset]).to be_a(String)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(forecast[:data][:attributes][:current_weather][:uvi]).to be_a_kind_of(Numeric)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_an(Integer)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
    expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)

    expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
    expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)

    forecast[:data][:attributes][:daily_weather].each do |day|
      expect(day).to be_a(Hash)
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)
      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(String)
      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(String)
      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a(Float)
      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a(Float)
      expect(day).to have_key(:conditions)
      expect(day[:conditions]).to be_a(String)
      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a(String)
    end

    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:hourly_weather].count).to eq(8)

    forecast[:data][:attributes][:hourly_weather].each do |hour|
      expect(hour).to be_a(Hash)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a(String)
      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour).to have_key(:wind_speed)
      expect(hour[:wind_speed]).to be_a(String)
      expect(hour).to have_key(:wind_direction)
      expect(hour[:wind_direction]).to be_a(String)
      expect(hour).to have_key(:conditions)
      expect(hour[:conditions]).to be_a(String)
      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a(String)
    end

    expect(forecast[:data][:attributes][:current_weather][:alerts]).to be_nil
    expect(forecast[:data][:attributes][:current_weather][:pressure]).to be_nil
    expect(forecast[:data][:attributes][:current_weather][:clouds]).to be_nil
  end

  it 'should return an error message when bad params are passed (sad path)', :vcr do
    location_params = {
      'location': ''
    }

    get '/api/v1/forecast', params: location_params

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to be_a(Hash)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Illegal argument from request: Insufficient info for location")

    expect(response_data).to have_key(:status_code)
    expect(response_data[:status_code]).to eq(400)
  end
end
