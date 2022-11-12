require 'rails_helper'

RSpec.describe CountryService do
  describe 'API endpoint' do
    it 'gets the info for all countries' do
      VCR.use_cassette('all_countries') do
        all_countries = CountryService.get_all_countries
        
        expect(all_countries).to be_a(Array)
        expect(all_countries.first).to be_a(Hash)
        all_countries.each do |country|
          expect(country[:name]).to be_a(String)
        end
      end
    end
  end
end