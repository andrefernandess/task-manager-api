class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    begin
      @users = User.find(params[:id])
      respond_with @users
    rescue
      head 404
    end
  end

end
