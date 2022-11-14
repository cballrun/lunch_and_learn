class CountryService

  def self.get_all_countries
    response = conn.get("/v2/all")
    parse(response.body)
  end

  def self.get_a_country(country)
    response = conn.get("/v2/name/#{country}")
    parse(response.body)
  end

  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end