# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  protect_from_forgery with: :exception

  # Curreent user:
  before_action :set_current_user

  # Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
