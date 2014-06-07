require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  after_filter :user_activity
  # layout :dirty_layout_hack
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # protect_from_forgery with: :null_session



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :sex
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :dob
    devise_parameter_sanitizer.for(:sign_up) << :devotion
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:sign_in) << :provider
    devise_parameter_sanitizer.for(:sign_in) << :uid
    devise_parameter_sanitizer.for(:sign_up) << :provider
    devise_parameter_sanitizer.for(:sign_up) << :uid
  end
  private
  def user_activity
    current_user.try :touch
  end

  def dirty_layout_hack
    if controller_name == "registrations" && action_name == "edit"
      return false
    end
    if controller_name == "others"
      return false
    end
  end
  def record_not_found
    redirect_to root_path
  end
end