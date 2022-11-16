require 'rails_helper'

RSpec.describe RecipeFacade do

  it 'gets recipes and the country' do
    VCR.use_cassette('thai_recipes') do
      recipes= RecipeFacade.get_recipes("thailand")
      recipe = recipes.first

      expect(recipes).to be_a(Array)
      expect(recipes.last).to be_a(Recipe)
      expect(recipe.country).to eq("thailand")
      expect(recipe.image).to be_a(String)
      expect(recipe.title).to be_a(String)
      expect(recipe.url).to be_a(String)
    end
  end

  it 'returns an empty array when there are no results' do
    VCR.use_cassette('recipe_service_random') do
      all_data = RecipeFacade.get_recipes("dzfdsa33r")
      
      expect(all_data).to eq([])
    end
  end
end