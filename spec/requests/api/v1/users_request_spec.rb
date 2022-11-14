require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'User Create' do
    describe 'happy path' do
      it 'creates a user with given valid data' do
        params = { name: "Randy Bobandy", email: "assistantsupervisor@sunnyvale.ca"}

        expect(User.count).to eq(0)
        post '/api/v1/users', params: params

        expect(response).to be_successful
        expect(User.count).to eq(1)
      end
    end
  end
end