require 'rails_helper'

RSpec.describe 'Tourist Sights API' do
  describe 'tourist sights index' do
    describe 'happy path' do
      it 'sends a list of tourist sights with attributes name, address, and place id' do
        VCR.use_cassette('paris_sight_data') do
          params = {country: 'france'}

          get "/api/v1/tourist_sights", params: params
    
          expect(response).to be_successful

          tourist_sight_data = JSON.parse(response.body, symbolize_names: true)
          tourist_sights = tourist_sight_data[:data]

          expect(tourist_sight_data).to be_a(Hash)
          expect(tourist_sights).to be_a(Array)

          tourist_sights.each do |sight|
            expect(sight).to be_a(Hash)
            expect(sight[:id]).to eq(nil)
            expect(sight[:type]).to eq("tourist_sight")
            expect(sight[:attributes].count).to eq(3)
            expect(sight[:attributes][:name]).to be_a(String)
            expect(sight[:attributes][:address]).to be_a(String)
            expect(sight[:attributes][:place_id]).to be_a(String)
          end
        end
      end
    end
  end
end