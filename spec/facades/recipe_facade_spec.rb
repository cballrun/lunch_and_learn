require 'rails_helper'

RSpec.describe RecipeFacade do

  it 'gets recipes and the country' do
    VCR.use_cassette('thai_recipes') do
      recipes_info = RecipeFacade.get_recipes("thailand")
      country = recipes_info[0]
      recipes = recipes_info[1]
      recipe = recipes_info[1][1]
      
      expect(country).to eq("thailand")
      expect(recipes.count).to eq(10)
      expect(recipes).to be_a(Array)
      expect(recipe).to be_a(Recipe)
      expect(recipe.image).to be_a(String)
      expect(recipe.title).to be_a(String)
      expect(recipe.url).to be_a(String)
    end
  end
end