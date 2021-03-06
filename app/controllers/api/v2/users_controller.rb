class Api::V2::UsersController < ApplicationController
  before_action :authenticable_with_token!, only: [:update, :destroy]

  def show
    begin
      users = User.find(params[:id])
      render json: users
    rescue
      head 404
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = current_user
    user.destroy
    head 204
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
