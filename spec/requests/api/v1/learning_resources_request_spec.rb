require 'rails_helper'

RSpec.describe 'Learning Resources API' do
  describe 'Learning Resources index' do
    describe 'happy path' do
      it 'sends one video and multiple images for the request' do
        VCR.use_cassette('laos_data') do
          params = {country: "laos"}
          
          get "/api/v1/learning_resources", params: params

          expect(response).to be_successful
         
          learning_resource_data = JSON.parse(response.body, symbolize_names: true)
          learning_resource = learning_resource_data[:data]
         
          expect(learning_resource_data).to be_a(Hash)

          expect(learning_resource).to be_a(Hash)
          expect(learning_resource.count).to eq(3)
          expect(learning_resource[:id]).to eq(nil)
          expect(learning_resource[:type]).to eq("learning_resource")
          expect(learning_resource[:attributes].count).to eq(3)
          expect(learning_resource[:attributes][:country]).to eq("laos")
          expect(learning_resource[:attributes][:video]).to be_a(Hash)
          expect(learning_resource[:attributes][:video].count).to eq(2)
          expect(learning_resource[:attributes][:video][:title]).to be_a(String)
          expect(learning_resource[:attributes][:video][:youtube_video_id]).to be_a(String)
          expect(learning_resource[:attributes][:images]).to be_a(Array)
          expect(learning_resource[:attributes][:images].first).to be_a(Hash)
        end
      end
    end

    describe 'sad path' do
      it 'returns empty arrays if nothing is found' do
        VCR.use_cassette('random_string_data') do
          params = {country: "98asdsa7gghsdfaq55daqwrff"}

          get "/api/v1/learning_resources", params: params
          binding.pry
          expect(response).to be_successful
        end
      end
    end
  end
end