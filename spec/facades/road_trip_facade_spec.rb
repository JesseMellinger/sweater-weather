require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it '.get_trip (happy path)', :vcr do
      origin, destination = "Denver,CO", "Pueblo,CO"

      trip = RoadTripFacade.get_trip(origin, destination)

      expect(trip).to be_a(RoadTrip)
      expect(trip.id).to be_nil

      expect(trip.end_city).to be_a(String)
      expect(trip.start_city).to be_a(String)
      expect(trip.travel_time).to be_a(String)

      expect(trip.weather_at_eta).to be_a(Hash)
      expect(trip.weather_at_eta).to have_key(:temperature)
      expect(trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(trip.weather_at_eta).to have_key(:conditions)
      expect(trip.weather_at_eta[:conditions]).to be_a(String)
    end

    it '.get_trip (sad path)', :vcr do
      origin, destination = "New York, NY", "London, UK"

      trip = RoadTripFacade.get_trip(origin, destination)

      expect(trip).to be_a(RoadTrip)
      expect(trip.id).to be_nil

      expect(trip.end_city).to be_a(String)
      expect(trip.start_city).to be_a(String)
      expect(trip.travel_time).to eq("Impossible Route")

      expect(trip.weather_at_eta).to be_a(Hash)
      expect(trip.weather_at_eta).to be_empty
    end
  end
end
