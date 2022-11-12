class RecipeFacade
  def self.get_recipes(country)
    recipe_data = RecipeService.get_recipes(country)
    recipes = recipe_data[:hits].map do |recipe|
      recipe_country = {country: recipe_data[:q]}
      data = recipe.merge(recipe_country)
      Recipe.new(data)
    end
  end
end