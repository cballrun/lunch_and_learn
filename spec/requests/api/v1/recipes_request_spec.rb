require 'rails_helper'

RSpec.describe 'Recipes API' do
  describe 'Recipes index' do
    describe 'happy path' do
      it 'sends a list of recipes based on a country search term' do
        params = {country: "thailand"}
        
        get "/api/v1/recipes", params: params
        binding.pry
        expect(response).to be_successful
      end
    end
  end
end