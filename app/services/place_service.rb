class PlaceService
  def self.get_tourist_sights(country)
    lng = CountryFacade.get_lng(country)
    lat = CountryFacade.get_lat(country)
    response = conn.get("?filter=circle:#{lng},#{lat},20000&categories=tourism.sights")
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