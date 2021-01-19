class Restaurant
  attr_reader :name,
              :address

  def initialize(restaurant_response)
    @name =restaurant_response[:businesses].first[:name]
    @address = restaurant_response[:businesses].first[:location][:display_address].join(', ')
  end
end
