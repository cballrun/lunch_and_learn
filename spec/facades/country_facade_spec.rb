require 'rails_helper'

RSpec.describe CountryFacade do
  it 'gets all of the countries' do
    VCR.use_cassette('all_countries') do
      countries = CountryFacade.get_all_countries

      countries.each do |country|
        expect(country).to be_a(Country)
        expect(country.name).to be_a(String)
      end
    end
  end

  it 'gets a random country' do
    VCR.use_cassette('all_countries') do
      country = CountryFacade.get_random_country

      expect(country).to be_a(Country)
      expect(country.name).to be_a(String)
    end
  end
end