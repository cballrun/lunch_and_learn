require 'rails_helper'

RSpec.describe 'Recipes API' do
  describe 'Recipes index' do
    describe 'happy path' do
      it 'sends a list of recipes based on a country search term' do
        VCR.use_cassette('thai_data') do
          params = {country: "thailand"}
          
          get "/api/v1/recipes", params: params
          
          expect(response).to be_successful
          
          recipes_data = JSON.parse(response.body, symbolize_names: true)
          recipes = recipes_data[:data]

          expect(recipes_data).to be_a(Hash)

          expect(recipes.count).to eq(10)

          recipes.each do |recipe|
            expect(recipe[:id]).to eq(nil)
            expect(recipe[:type]).to eq("recipe")
            expect(recipe[:attributes].count).to eq(4)
            expect(recipe[:attributes][:title]).to be_a(String)
            expect(recipe[:attributes][:url]).to be_a(String)
            expect(recipe[:attributes][:country]).to eq("thailand")
            expect(recipe[:attributes][:image]).to be_a(String)
          end
        end
      end

      xit 'picks a random country for the search term if one is not given' do
        VCR.use_cassette('random_country_recipes') do
          
          get "/api/v1/recipes"

          expect(response).to be_successful
          
          recipes_data = JSON.parse(response.body, symbolize_names: true)
          recipes = recipes_data[:data]
          
          expect(recipes_data).to be_a(Hash)
        
          recipes.each do |recipe|
            expect(recipe[:id]).to eq(nil)
            expect(recipe[:type]).to eq("recipe")
            expect(recipe[:attributes].count).to eq(4)
            expect(recipe[:attributes][:title]).to be_a(String)
            expect(recipe[:attributes][:url]).to be_a(String)
            expect(recipe[:attributes][:country]).to be_a(String)
            expect(recipe[:attributes][:image]).to be_a(String)
          end
        end
      end
    end

    describe 'sad path' do
      it 'sends an empty data array back if there are no matches' do
        VCR.use_cassette('no_match_country_search') do
          params = {country: "sunnyvale trailer park"}
          
          get "/api/v1/recipes", params: params

          expect(response).to be_successful

          no_match_data = JSON.parse(response.body, symbolize_names: true)

          expect(no_match_data).to eq({"data": []})
        end
      end

      it 'sends an empty data array back if the param is an empty string' do
        VCR.use_cassette('empty_string_search') do
          params = {country: ""}
          
          get "/api/v1/recipes", params: params

          expect(response).to be_successful

          empty_string_data = JSON.parse(response.body, symbolize_names: true)

          expect(empty_string_data).to eq({"data": []})
        end
      end
    end
  end
end