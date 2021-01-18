require 'rails_helper'

RSpec.describe Image do
  it 'exists and has attributes' do
    image_json = File.read('spec/fixtures/image_data.json')
    image_data = JSON.parse(image_json, symbolize_names: true)
    location_params = {
      location: 'denver,co'
    }

    image = Image.new(image_data, location_params)

    expect(image).to be_an(Image)
    expect(image.id).to be_nil

    expect(image.image).to be_a(Hash)
    expect(image.image).to have_key(:location)
    expect(image.image[:location]).to eq(location_params[:location])

    expect(image.image).to have_key(:image_url)
    expect(image.image[:image_url]).to be_a(String)

    expect(image.image).to have_key(:attribution)
    expect(image.image[:attribution]).to be_a(Hash)

    expect(image.image[:attribution]).to have_key(:message)
    expect(image.image[:attribution][:message]).to be_a(String)

    expect(image.image).to_not have_key(:title)
    expect(image.image).to_not have_key(:owner)
  end
end
