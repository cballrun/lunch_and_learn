class RecipeFacade
  def self.get_recipes(country)
    recipe_data = RecipeService.get_recipes(country)
    recipes = recipe_data[:hits].map do |recipe|
      Recipe.new(recipe)
    end
    country, recipes = [recipe_data[:q], recipes]
  end

end