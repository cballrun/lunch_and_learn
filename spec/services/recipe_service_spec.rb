require 'rails_helper'

RSpec.describe RecipeService do
  describe 'API endpoint' do

    it 'gets a recipe info' do
      VCR.use_cassette('thai_data') do
        all_data = RecipeService.get_recipes("thailand")
        all_recipe_data = all_data[:hits]
        
        expect(all_data).to be_a(Hash)
        expect(all_data[:q]).to be_a(String)
        expect(all_data[:q]).to eq("thailand")
        
        all_recipe_data.each do |recipe|
          expect(recipe).to have_key(:recipe)
          expect(recipe[:recipe][:label]).to be_a(String)
          expect(recipe[:recipe][:url]).to be_a(String)
          expect(recipe[:recipe][:image]).to be_a(String)
          expect(recipe[:recipe]).to_not have_key(:country)
          expect(recipe).to_not have_key(:country)
        end
      end
    end

    it 'returns an empty array if no recipes match' do
      VCR.use_cassette('recipe_service_random') do
        all_data = RecipeService.get_recipes("dzfdsa33r")
        
        expect(all_data[:hits]).to eq([])
      end
    end
  end
end