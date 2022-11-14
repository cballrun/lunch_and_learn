class CountryFacade

  def self.get_all_countries
    countries = CountryService.get_all_countries
    countries.map do |country|
      Country.new(country)
    end
  end

  def self.get_random_country
    countries = CountryFacade.get_all_countries
    countries.sample
  end

  def self.get_lng(country)
    country = CountryService.get_a_country(country).first

    country[:latlng].last#, country[:latlng].first
  end

  def self.get_lat(country)
    country = CountryService.get_a_country(country).first

    country[:latlng].first#, country[:latlng].first
  end

  def self.get_latlng(country)
    country = CountryService.get_a_country(country).first
    country[:latlng]
  end
end