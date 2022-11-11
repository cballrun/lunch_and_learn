class RecipeFacade
  def self.get_recipes(country)
    recipe_data = RecipeService.get_recipes(country)
    recipe_data[:hits].map do |recipe|
      Recipe.new(recipe)
    end
  end

end