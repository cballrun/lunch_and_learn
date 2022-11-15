require 'rails_helper'

RSpec.describe 'Favorites API' do
  describe 'favorites create' do
    describe 'happy path' do

      it 'creates a favorite in the proper format' do
        user_1 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = {
          "api_key": user_1.api_key,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/.....",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        expect(Favorite.count).to eq(0)

        post '/api/v1/favorites', params: params
        success_message = JSON.parse(response.body, symbolize_names: true)
        
        expect(Favorite.count).to eq(1)
        
        expect(response).to be_successful
        expect(response).to have_http_status(201)
        expect(success_message[:success]).to eq("Favorite added successfully.")
      end
    end

    describe 'sad path' do
      it 'does not create a favorite if the user does not exist' do
        user_1 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = {
          "api_key": "dfdsad88",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/.....",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        expect(Favorite.count).to eq(0)

        post '/api/v1/favorites', params: params
        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(Favorite.count).to eq(0)
      
        expect(response).to have_http_status(400)
        expect(error_message[:error]).to eq("User does not exist")
      end
    end
  end
end
