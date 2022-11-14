require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'User Create' do
    describe 'happy path' do
      it 'creates a user with given valid data' do
        params = { name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca"}
        expect(User.count).to eq(0)
        
        post '/api/v1/users', params: params
        
        user = User.last
        user_data = JSON.parse(response.body, symbolize_names: true)
        user_info = user_data[:data]

        expect(User.count).to eq(1)
        
        expect(response).to be_successful
        expect(response).to have_http_status(201)
       
        expect(user_data).to be_a(Hash)

        expect(user_info[:id].to_i).to be_a(Integer)
        expect(user_info[:type]).to eq("user")
        expect(user_info[:attributes].count).to eq(3)
        expect(user_info[:attributes][:name]).to eq("Randy Bobandy")
        expect(user_info[:attributes][:email]).to eq("assistantsupervisor@sunnyvale.ca")
        expect(user_info[:attributes][:api_key]).to be_a(String)

        expect(user.api_key).to_not eq(nil)
      end
    end
  end
end