class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize!
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def authorize_super_admin!
    unless user_signed_in? && current_user.super_admin
      redirect_to events_path
    end
  end
end
