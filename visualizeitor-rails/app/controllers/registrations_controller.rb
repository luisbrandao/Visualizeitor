# app/controllers/users/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:param1, :param2, :param3])
  end
end
