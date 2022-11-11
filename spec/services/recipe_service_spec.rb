require 'rails_helper'

RSpec.describe RecipeService do
  describe 'API endpoint' do

    it 'gets a recipe info' do
      VCR.use_cassette('thai_data') do
        recipe_data = RecipeService.get_recipe("thailand")
        binding.pry
        expect(recipe_data).to be_a(Hash)
      end
    end
  end
end