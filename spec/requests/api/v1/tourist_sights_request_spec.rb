require 'rails_helper'

RSpec.describe 'Tourist Sights API' do
  describe 'tourist sights index' do
    describe 'happy path' do
      it 'sends a list of tourist sights with attributes name, address, and place id' do
        VCR.use_cassette('paris_data') do
          params = {country: 'france'}

          get "/api/v1/tourist_sights", params: params

          expect(response).to be_successful
        end
      end
    end
  end
end