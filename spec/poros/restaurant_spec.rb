require 'rails_helper'

RSpec.describe Restaurant do
  it 'exists and has attributes' do
    restaurant_json = File.read('spec/fixtures/restaurant_json.json')

    restaurant_data = JSON.parse(restaurant_json, symbolize_names: true)

    restaurant = Restaurant.new(restaurant_data)

    expect(restaurant).to be_a(Restaurant)

    expect(restaurant.address).to be_a(String)
    expect(restaurant.name).to be_a(String)
  end
end
