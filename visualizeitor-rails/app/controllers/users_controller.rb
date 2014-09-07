class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
  end

  # POST /:id/change_role
  def change_role
    user = User.find(params[:user_id])
    user.role = :admin
    user.save!

    redirect_to users_path
  end
end