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
    # in_responses_waiting = Interest.where(to_user_id: current_user.id, response: nil)
    # in_responses_waiting_profiles = []
    # in_responses_waiting.each do |in_resp|
    #   in_responses_waiting_profiles << Profile.find(user_id: in_resp.user_id)
    # end

    return {
      id:         user.id,
      dob:        user.dob,
      name:       user.name,
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
      avatar:     user.avatar,
      in_response:  Interest.where(to_user_id: current_user.id, user_id: user.id).first,
      out_response: Interest.where(user_id: current_user.id, to_user_id: user.id).first
    }
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :sex
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :dob
  end
  private
  def user_activity
    current_user.try :touch
  end

end
