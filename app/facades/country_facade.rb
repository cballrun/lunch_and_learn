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
end