class UsersController < ApplicationController
  def index
    @users = User.alphabetical
  end
end
