require 'rails_helper'

RSpec.describe ImageFacade do
  describe 'class methods' do
    it '.get_image (happy path)', :vcr do
      location_params = {
        'location' => 'denver,co'
      }

      image = ImageFacade.get_image(location_params)

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

    it '.get_image (sad path)', :vcr do
      location_params = {
        'location' => ''
      }

      image = ImageFacade.get_image(location_params)

      expect(image).to be_a(Hash)
      expect(image).to have_key(:stat)
      expect(image[:stat]).to eq("fail")

      expect(image).to have_key(:message)
      expect(image[:message]).to eq("Parameterless searches have been disabled. Please use flickr.photos.getRecent instead.")
    end
  end
end
