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
      it 'returns an error message and does not create a favorite if the user does not exist' do
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
        expect(error_message[:error]).to eq("User does not exist.")
      end

      it 'does not create a favorite with invalid params' do
        user_1 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = {
          "api_key": user_1.api_key,
          "recipe_link": "https://www.tastingtable.com/.....",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }

        expect(Favorite.count).to eq(0)

        post '/api/v1/favorites', params: params
        error_message = JSON.parse(response.body, symbolize_names: true)
    
        expect(Favorite.count).to eq(0)
        expect(response).to have_http_status(400)
        expect(error_message[:error]).to eq("Country can't be blank")
      end

      it 'does not create a favorite with no params' do
        expect(Favorite.count).to eq(0)
        
        post '/api/v1/favorites'

        expect(response).to have_http_status(400)
        expect(Favorite.count).to eq(0)
      end
    end
  end

  describe 'favorites index' do
    describe 'happy path' do

      it 'gets all of a users favorites if data is valid' do
        user_1 = User.create!(name: "Jim Lahey", email: "supervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))
        
        u1_f1 = user_1.favorites.create!(country: "laos", recipe_link: "www.fakerecipelink.com/grilledcheese", recipe_title: "grilled cheese")
        u1_f2 = user_1.favorites.create!(country: "laos", recipe_link: "www.fakerecipelink.com/friedchicken", recipe_title: "fried chicken")
        u1_f3 = user_1.favorites.create!(country: "china", recipe_link: "www.fakerecipelink.com/burritos", recipe_title: "tasty burritos")

        params = {
          "api_key": user_1.api_key
        }

        get '/api/v1/favorites', params: params
        favorites_data = JSON.parse(response.body, symbolize_names: true)
        favorites_info = favorites_data[:data]
        
        expect(response).to be_successful
        expect(response).to have_http_status(201)
        expect(favorites_data).to be_a(Hash)
        expect(favorites_info).to be_a(Array)
        expect(favorites_info.count).to eq(3) 
        
        favorites_info.each do |favorite|
          expect(favorite[:id].to_i).to be_a(Integer)
          expect(favorite[:type]).to eq("favorite")
          expect(favorite[:attributes].count).to eq(4)
          expect(favorite[:attributes][:recipe_title]).to be_a(String)
          expect(favorite[:attributes][:recipe_link]).to be_a(String)
          expect(favorite[:attributes][:country]).to be_a(String)
          expect(favorite[:attributes][:created_at]).to be_a(String)
        end
      end
    end

    describe 'sad path' do
      it 'returns an error message and http status 400 if the user does not exist' do
        user_1 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = {
          "api_key": "dfdsad88",
        }

        get '/api/v1/favorites', params: params
        error_message = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(error_message[:error]).to eq("User does not exist.")
      end

      it 'returns an empty data array if the user has no favorites' do
        user_1 = User.create!(name: "Jim Lahey", email: "supervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = {
          "api_key": user_1.api_key
        }

        get '/api/v1/favorites', params: params
        no_favorites_data = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful
        expect(no_favorites_data).to eq({"data": []})
      end
    end
  end
end
