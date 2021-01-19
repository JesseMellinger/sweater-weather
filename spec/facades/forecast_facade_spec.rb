require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    it '.get_forecast (happy path)', :vcr do
      location_params = {
        'location' => 'denver,co'
      }

      forecast = ForecastFacade.get_forecast(location_params)

      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to be_nil

      expect(forecast.current_weather).to be_a(CurrentWeather)
      expect(forecast.current_weather.datetime).to be_a(String)
      expect(forecast.current_weather.sunrise).to be_a(String)
      expect(forecast.current_weather.sunset).to be_a(String)
      expect(forecast.current_weather.temperature).to be_a(Float)
      expect(forecast.current_weather.feels_like).to be_a(Float)
      expect(forecast.current_weather.humidity).to be_an(Integer)
      expect(forecast.current_weather.uvi).to be_a_kind_of(Numeric)
      expect(forecast.current_weather.visibility).to be_an(Integer)
      expect(forecast.current_weather.conditions).to be_a(String)
      expect(forecast.current_weather.icon).to be_a(String)

      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.count).to eq(5)

      forecast.daily_weather.each do |day|
        expect(day.date).to be_a(String)
        expect(day.sunrise).to be_a(String)
        expect(day.sunset).to be_a(String)
        expect(day.max_temp).to be_a(Float)
        expect(day.min_temp).to be_a(Float)
        expect(day.conditions).to be_a(String)
        expect(day.icon).to be_a(String)
      end

      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.count).to eq(8)

      forecast.hourly_weather.each do |hour|
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
    end

    it '.get_forecast (sad path)', :vcr do
      location_params = {
        'location' => ''
      }

      response_data = ForecastFacade.get_forecast(location_params)

      expect(response_data[:info][:statuscode]).to eq(400)
      expect(response_data[:info][:messages].first).to eq("Illegal argument from request: Insufficient info for location")
      expect(response_data[:results].first[:providedLocation][:location]).to eq("")
      expect(response_data[:results].first[:providedLocation][:locations]).to be_nil
    end
  end
end
