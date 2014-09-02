class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :devise_controller?

  before_action :check_role, unless: :devise_controller?

  def check_role
  	if (current_user && current_user.normal?)
  		redirect_to edit_user_registration_path
  	end

  end
end
