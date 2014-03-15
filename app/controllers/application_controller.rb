require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  after_filter :user_activity
  # protect_from_forgery with: :null_session

  def make_user(user)
    return {
      id:         user.id,
      updated_at: user.updated_at,
      sex:        user.sex,
      visitors:   Visitor.where(viewed_id: user.id).count,
      profile:    user.profile,
      contact:    user.contact,
      about:      user.about,
      religion:   user.religion,
      kundali:    user.kundali,
      family:     user.family,
      hobby:      user.hobby,
      education:  user.education,
      lifestyle:  user.lifestyle,
      desire:     user.desire,
      image:      user.images.all,
      avatar:     user.avatar
    }
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :sex
  end
  private
  def user_activity
    current_user.try :touch
  end

end
