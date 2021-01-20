require 'rails_helper'

RSpec.describe Weather do
  it 'exists and has attributes' do
    weather_json = File.read('spec/fixtures/weather_data.json')
    weather_data = JSON.parse(weather_json, symbolize_names: true)

    travel_time = 6634

    weather = Weather.new(weather_data, travel_time)

    expect(weather).to be_a(Weather)

    expect(weather.conditions).to be_a(String)
    expect(weather.temperature).to be_a(Float)
  end
end
