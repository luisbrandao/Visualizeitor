class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_any!, unless: :devise_controller?

  #before_action :check_role, unless: :devise_controller?

#  def check_role
#  	if (current_user && current_user.normal?)
#  		redirect_to edit_user_registration_path
#  	end
#  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :access, :name, :login, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :access, :name, :login, :password_confirmation])
  end
end
