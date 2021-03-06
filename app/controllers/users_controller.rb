class UsersController < ApplicationController
  before_action :authorize!
  before_action :authorize_super_admin!
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.alphabetical
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated user."
      redirect_to users_path
    else
      flash[:alert] = "Unable to update user."
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "Successfully removed user #{@user.name}."
      redirect_to users_path
    else
      flash[:alert] = "Unable to remove user #{@user.name}."
      redirect_to users_path
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :super_admin, :admin)
  end
end
