class ImageFacade
  def self.get_image(location)
    image_response = ImageService.get_image_by_location(location)

    return Image.new(image_response, location) if image_response[:stat] == "ok"
    return image_response
  end
end
