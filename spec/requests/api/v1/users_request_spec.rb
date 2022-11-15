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

    describe 'sad path' do
      it 'does not create a user given a duplicate email' do
        params = { name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca"}
        expect(User.count).to eq(0)
        
        post '/api/v1/users', params: params

        expect(response).to be_successful
        expect(User.count).to eq(1)

        post '/api/v1/users', params: params
        
        # expect(response).to be_successful
        expect(response).to have_http_status(400)
        
        error_message = JSON.parse(response.body, symbolize_names: true)
        
        expect(User.count).to eq(1)
        expect(error_message[:message]).to eq("Email has already been taken")
      end

      xit 'does not create a user given invalid user info' do
        params = { name: 1536, email: 36.0}
        expect(User.count).to eq(0)
        
        post '/api/v1/users', params: params
        binding.pry 
        expect(response).to be_successful
        expect(response).to have_http_status(400)
        expect(User.count).to eq(0)

        error_message = JSON.parse(response.body, symbolize_names: true)
        binding.pry
        #xpect(error_message[:m])
      end
    end
  end
end