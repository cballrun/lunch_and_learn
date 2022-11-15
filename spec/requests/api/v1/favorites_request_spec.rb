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

        post '/api/v1/favorites', params: params

        expect(response).to be_successful
      end
    end
  end
end
