class Api::V1::FavoritesController < ApplicationController
  before_action :set_user

  def index 
    if !@user.nil?
      favorites = @user.favorites
      render json: FavoriteSerializer.new(favorites), status: 201
    else
      render json: { error: "User does not exist." }, status: 400
    end
  end

  def create
    if !@user.nil?
      favorite = @user.favorites.new(favorite_params)
      if favorite.save
        render json: { success: "Favorite added successfully." }, status: 201
      else
        render json: { error: error_message(favorite.errors) }, status: 400
      end
    else
      render json: { error: "User does not exist." }, status: 400
    end
  end

  private 
  
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
  
  def set_user
    @user = User.find_by(api_key: params[:api_key])
  end
end
