class ImageService
  def self.get_image_by_location(location)
    response = conn.get do |req|
      req.params['method'] = 'flickr.photos.search'
      req.params['api_key'] = ENV['FLICKR_API_KEY']
      req.params['tags'] = location['location']
      req.params['per_page'] = 1
      req.params['format'] = 'json'
      req.params['extras'] = 'url_l'
    end
    parse_response(response)
  end

  private
  def self.conn
    Faraday.new('https://api.flickr.com/services/rest')
  end

  def self.parse_response(response)
    JSON.parse(response.body.gsub(/jsonFlickrApi|\(|\)/, ''), symbolize_names: true)
  end
end
