class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex(15)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: { message: error_message(user.errors) }, status: 400
    end

  end

  private 
  def user_params
    params.permit(:name, :email)
  end
end
