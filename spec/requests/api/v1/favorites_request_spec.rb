require 'rails_helper'

RSpec.describe 'Favorites API' do
  describe 'favorites index' do
    describe 'happy path' do

      it 'gets favorites' do
        user_1 = User.create!(name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca", api_key: SecureRandom.hex(15))

        params = { api_key: user_1.api_key } 

        get '/api/v1/favorites', params: params

        expect(response).to be_successful
      end
    end
  end
end
