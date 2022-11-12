require 'rails_helper'

RSpec.describe 'Learning Resources API' do
  describe 'Learning Resources index' do
    describe 'happy path' do
      it 'sends one video and multiple images for the request' do
        VCR.use_cassette('laos_data') do
          params = {country: "laos"}
          
          get "/api/v1/learning_resources", params: params

          expect(response).to be_successful
        end
      end
    end
  end
end