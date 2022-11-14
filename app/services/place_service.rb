class PlaceService
  def self.get_places(place)
    # api_key = ENV['places_api_key']
    response = conn.get("")
    parse(response.body)
  end

  def self.conn
    Faraday.new("https://api.geoapify.com/v2/places") do |f|
      f.params['apiKey'] = ENV['places_api_key']
    end
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end