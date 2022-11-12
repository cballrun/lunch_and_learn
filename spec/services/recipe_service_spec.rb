require 'rails_helper'

RSpec.describe RecipeService do
  describe 'API endpoint' do

    it 'gets a recipe info' do
      VCR.use_cassette('thai_data') do
        all_data = RecipeService.get_recipes("thailand")
        all_recipe_data = all_data[:hits]
        
        expect(all_data).to be_a(Hash)
        expect(all_data[:q]).to be_a(String)
        expect(all_recipe_data.count).to eq(10)
        
        all_recipe_data.each do |recipe|
          expect(recipe).to have_key(:recipe)
          expect(recipe[:recipe][:label]).to be_a(String)
          expect(recipe[:recipe][:url]).to be_a(String)
          expect(recipe[:recipe][:image]).to be_a(String)
        end
      end
    end
  end
end