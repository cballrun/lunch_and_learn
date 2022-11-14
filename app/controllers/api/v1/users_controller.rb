class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      user.api_key = SecureRandom.hex(15)
      render json: UserSerializer.new(user)
    else
      "beepbooop"
    end

  end

  private 
  def user_params
    params.permit(:name, :email)
  end
end
