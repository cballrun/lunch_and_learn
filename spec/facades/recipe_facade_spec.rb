require 'rails_helper'

RSpec.describe RecipeFacade do

  it 'gets recipes' do
    VCR.use_cassette('thai_recipes') do
      x = RecipeFacade.get_recipes("thailand")
      binding.pry
      expect(x.count).to eq(10)
    end
  end
end