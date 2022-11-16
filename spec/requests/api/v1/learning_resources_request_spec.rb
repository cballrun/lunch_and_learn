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
          expect(response).to be_successful

          learning_resource_data = JSON.parse(response.body, symbolize_names: true)
          learning_resource = learning_resource_data[:data]

          expect(learning_resource[:attributes][:country]).to eq("98asdsa7gghsdfaq55daqwrff")
          expect(learning_resource[:attributes][:video]).to eq([])
          expect(learning_resource[:attributes][:images]).to eq([])
        end
      end

      it 'returns empty arrays with an empty string' do
        VCR.use_cassette('learning_resource_empty_string') do
        
          params = {country: ""}
          get "/api/v1/learning_resources", params: params
          expect(response).to be_successful

          learning_resource_data = JSON.parse(response.body, symbolize_names: true)
          learning_resource = learning_resource_data[:data]

          expect(learning_resource[:attributes][:country]).to eq("Invalid search")
          expect(learning_resource[:attributes][:video]).to eq([])
          expect(learning_resource[:attributes][:images]).to eq([])
        end
      end

      it 'returns empty arrays with a random param' do
        VCR.use_cassette('learning_resource_random_param') do
        
          params = {random_param: "laos"}
          get "/api/v1/learning_resources", params: params
          expect(response).to be_successful

          learning_resource_data = JSON.parse(response.body, symbolize_names: true)
          learning_resource = learning_resource_data[:data]

          expect(learning_resource[:attributes][:country]).to eq("Invalid search")
          expect(learning_resource[:attributes][:video]).to eq([])
          expect(learning_resource[:attributes][:images]).to eq([])
        end
      end
    end
  end
end