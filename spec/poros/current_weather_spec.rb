require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    forecast_json = File.read('spec/fixtures/forecast_json.json')

    forecast_data = JSON.parse(forecast_json, symbolize_names: true)

    weather = CurrentWeather.new(forecast_data)

    expect(weather).to be_a(CurrentWeather)

    expect(weather.summary).to be_a(String)
    expect(weather.temperature).to be_a(String)
  end
end
