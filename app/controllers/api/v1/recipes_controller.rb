class Api::V1::RecipesController < ApplicationController

  def index
    if params[:country]
      recipes = RecipeFacade.get_recipes(params[:country])
      render json: RecipeSerializer.new(recipes)
    elsif params.keys.count == 2
      country = CountryFacade.get_random_country
      recipes = RecipeFacade.get_recipes(country.name)
      render json: RecipeSerializer.new(recipes)
    else
      render json: { error: "Invalid request" }, status: 400
    end
  end

end