require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    weather_json = File.read('spec/fixtures/weather_data.json')
    weather_data = JSON.parse(weather_json, symbolize_names: true)

    weather = CurrentWeather.new(weather_data)
    
    expect(weather).to be_a(CurrentWeather)

    expect(weather.conditions).to be_a(String)
    expect(weather.datetime).to be_a(String)
    expect(weather.feels_like).to be_a(Float)
    expect(weather.humidity).to be_an(Integer)
    expect(weather.icon).to be_a(String)
    expect(weather.sunrise).to be_a(String)
    expect(weather.sunset).to be_a(String)
    expect(weather.temperature).to be_a(Float)
    expect(weather.uvi).to be_a(Float)
    expect(weather.visibility).to be_an(Integer)
  end
end
