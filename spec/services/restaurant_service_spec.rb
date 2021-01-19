require 'rails_helper'

RSpec.describe 'RestaurantService' do
  it 'should return parsed response data (happy path)', :vcr  do
    destination, eta, food = "pueblo,co", 1611083541, "chinese"

    response = RestaurantService.get_restaurant_by_city(destination, eta, food)

    expect(response).to be_a(Hash)

    expect(response).to have_key(:businesses)
    expect(response[:businesses]).to be_an(Array)
    expect(response[:businesses].count).to eq(1)

    expect(response[:businesses].first).to have_key(:name)
    expect(response[:businesses].first[:name]).to be_a(String)

    expect(response[:businesses].first).to have_key(:location)
    expect(response[:businesses].first[:location]).to be_a(Hash)

    expect(response[:businesses].first[:location]).to have_key(:display_address)
    expect(response[:businesses].first[:location][:display_address]).to be_an(Array)
    expect(response[:businesses].first[:location][:display_address].first).to be_a(String)
  end
end
