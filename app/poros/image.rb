class Image
  attr_reader :id,
              :image

  def initialize(image_data, location)
    @id = nil
    @image = get_formatted_data(image_data, location)
  end

  private
  def get_formatted_data(image_data, location)
    image_value = Hash.new
    image_value[:location] = location[:location]
    image_value[:image_url] = image_data[:photos][:photo].first[:url_l]
    image_value[:attribution] = Hash.new
    image_value[:attribution][:message] = "This product uses the Flickr API but is not endorsed or certified by SmugMug, Inc."
    image_value
  end
end
