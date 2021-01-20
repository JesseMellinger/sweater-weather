require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists and has attributes' do
    day_json = File.read('spec/fixtures/day_data.json')
    weather_data = JSON.parse(day_json, symbolize_names: true)

    weather = DailyWeather.new(weather_data)
    
    expect(weather).to be_a(DailyWeather)

    expect(weather.conditions).to be_a(String)
    expect(weather.date).to be_a(String)
    expect(weather.icon).to be_a(String)
    expect(weather.max_temp).to be_a(Float)
    expect(weather.min_temp).to be_a(Float)
    expect(weather.sunrise).to be_a(String)
    expect(weather.sunset).to be_a(String)
  end
end
