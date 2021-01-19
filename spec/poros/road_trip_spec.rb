require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes' do
    origin, destination = "Denver,CO", "Pueblo,CO"

    weather_json = File.read('spec/fixtures/weather_data.json')
    weather_data = JSON.parse(weather_json, symbolize_names: true)
    route_json = File.read('spec/fixtures/route_data.json')
    route_data = JSON.parse(route_json, symbolize_names: true)

    trip = RoadTrip.new(origin, destination, route_data, weather_data)

    expect(trip).to be_a(RoadTrip)
    expect(trip.id).to be_nil

    expect(trip.end_city).to be_a(String)
    expect(trip.start_city).to be_a(String)
    expect(trip.travel_time).to be_a(String)

    expect(trip.weather_at_eta).to be_a(Weather)
    expect(trip.weather_at_eta.temperature).to be_a(Float)
    expect(trip.weather_at_eta.conditions).to be_a(String)
  end
end
