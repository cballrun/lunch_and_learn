require 'rails_helper'

RSpec.describe CountryService do
  describe 'API endpoint' do
    it 'gets the info for all countries' do
      VCR.use_cassette('all_countries') do
        all_countries = CountryService.get_all_countries
        
        expect(all_countries).to be_a(Array) #check: add count?
        expect(all_countries.first).to be_a(Hash)
        all_countries.each do |country|
          expect(country[:name]).to be_a(String)
        end
      end
    end

    it 'gets the info for one country by name' do
      VCR.use_cassette('france_data') do
        france_array = CountryService.get_a_country('france')
        france_data = france_array.first
     
        expect(france_array).to be_a(Array)
        expect(france_data).to be_a(Hash)

        expect(france_data[:name]).to eq("France")
        expect(france_data[:population]).to be_a(Integer)
        expect(france_data[:latlng]).to be_a(Array)
        expect(france_data[:latlng].count).to eq(2)
        expect(france_data[:latlng].first).to be_a(Float)
      end
    end
  end
end