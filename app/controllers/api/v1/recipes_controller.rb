class Api::V1::RecipesController < ApplicationController

  def index
    if params[:country]
      recipes = RecipeFacade.get_recipes(params[:country])
      render json: RecipeSerializer.new(recipes)
    else
      country = CountryFacade.get_random_country
      recipes = RecipeFacade.get_recipes(country.name)
      render json: RecipeSerializer.new(recipes)
    end
  end

end