require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  after_filter :user_activity
  helper_method :make_user
  layout :dirty_layout_hack
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # protect_from_forgery with: :null_session
  helper_method :make_user, :make_user_snippet

  def make_user(user)
    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first

    profile = user.profile

    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "Id: #{profile.id}"

    user_ret = {
      id:         user.id,
      dob:        dob,
      age:        age,
      name:       truncate(name).capitalize,
      updated_at: time_ago_in_words(user.updated_at),
      created_at: time_ago_in_words(user.created_at),
      sex:        user.sex.capitalize,
      visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
      profile:    profile,
      contact:    user.contact,
      about:      user.about,
      religion:   user.religion,
      devotion:   user.devotion,
      kundali:    user.kundali,
      family:     user.family,
      occupation:     user.occupation,
      hobby:      user.hobby,
      education:  user.education,
      lifestyle:  user.lifestyle,
      desire:     user.desire,
      image:      user.images.all,
      images_count:      user.images_count.to_i,
      avatar:     user.avatar,
      in_response:  in_response,
      out_response: out_response,
      shortlist:    Shortlist.where(user_id: current_user.id, to_user_id: user.id).first,
    }
    return user_ret;
  end  
  def make_user_snippet(user)
    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first

    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "Profile id - #{profile.id}"

    user_ret = {
      id:         user.id,
      dob:        dob,
      age:        age,
      name:       titleize(truncate(name)),
      updated_at: time_ago_in_words(user.updated_at),
      created_at: time_ago_in_words(user.created_at),
      visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
      profile:    user.profile,
      about:      user.about,
      religion:   user.religion,
      devotion:   user.devotion,
      image:      user.images.all,
      avatar:     user.avatar,
      in_response:  in_response,
      out_response: out_response,
      shortlist:    Shortlist.where(user_id: current_user.id, to_user_id: user.id).first,
    }
    return user_ret;
  end

  def calculate_age(birthday)
    Date.today.year - birthday.to_date.year
  end
  def show_name_to_accepted(in_response, out_response)
    if (in_response) || (out_response && out_response.response == 1)
      return true
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :sex
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :dob
    devise_parameter_sanitizer.for(:sign_up) << :devotion
  end
  private
  def user_activity
    current_user.try :touch
  end

  def dirty_layout_hack
    if controller_name == "registrations" && action_name == "edit"
      return false
    end
  end
  def record_not_found
    redirect_to root_path
  end
end