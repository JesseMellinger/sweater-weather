require 'rails_helper'

RSpec.describe Munchie do
  it 'exists and has attributes' do
    destination = "pueblo,co"
    eta = 1611085215

    forecast_json = File.read('spec/fixtures/forecast_json.json')
    restaurant_json = File.read('spec/fixtures/restaurant_json.json')

    forecast_data = JSON.parse(forecast_json, symbolize_names: true)
    restaurant_data = JSON.parse(restaurant_json, symbolize_names: true)

    munchie = Munchie.new(destination, eta, forecast_data, restaurant_data)

    expect(munchie).to be_a(Munchie)
    expect(munchie.id).to be_nil

    expect(munchie.destination_city).to be_a(String)

    expect(munchie.forecast).to be_a(CurrentWeather)
    expect(munchie.forecast.summary).to be_a(String)
    expect(munchie.forecast.temperature).to be_a(String)

    expect(munchie.restaurant).to be_a(Restaurant)
    expect(munchie.restaurant.name).to be_a(String)
    expect(munchie.restaurant.address).to be_a(String)

    expect(munchie.travel_time).to be_a(String)
  end
end
