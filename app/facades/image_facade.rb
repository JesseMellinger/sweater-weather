class ImageFacade
  def self.get_image(location)
    image_response = ImageService.get_image_by_location(location)
    Image.new(image_response, location)
  end
end
