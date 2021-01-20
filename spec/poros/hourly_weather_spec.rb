require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists and has attributes' do
    day_json = File.read('spec/fixtures/hour_data.json')
    weather_data = JSON.parse(day_json, symbolize_names: true)

    weather = HourlyWeather.new(weather_data)
    
    expect(weather).to be_a(HourlyWeather)

    expect(weather.conditions).to be_a(String)
    expect(weather.icon).to be_a(String)
    expect(weather.temperature).to be_a(Float)
    expect(weather.time).to be_a(String)
    expect(weather.wind_direction).to be_a(String)
    expect(weather.wind_speed).to be_a(String)
  end
end
