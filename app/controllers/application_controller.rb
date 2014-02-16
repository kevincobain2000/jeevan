class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :sex
  end
end
