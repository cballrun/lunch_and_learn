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

  it 'gets the latitude and longitude of a given country' do
    VCR.use_cassette('paris_sight_data') do
      latlng = CountryFacade.get_latlng('france')
  
      expect(latlng).to be_a(Array)
    end
  end

  it 'latlng works with ecuador' do
    VCR.use_cassette('ecuador_data',:allow_playback_repeats => true) do
      latlng = CountryFacade.get_latlng("ecuador")
     
      expect(latlng).to be_a(Array)

    end
  end

  it 'works with an invalid country' do
    VCR.use_cassette('invalid_country_data') do
      latlng = CountryFacade.get_latlng("esadfdsa558s3")

      expect(latlng).to be_a(Array)
      expect(latlng).to eq([-10000.0, 10000.0])
    end
  end
end