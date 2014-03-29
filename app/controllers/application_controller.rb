require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :for_notification
  protect_from_forgery with: :exception
  after_filter :user_activity
  # protect_from_forgery with: :null_session

  def make_user(user)
    dob = user.dob.gsub("/","-")
    age = user.dob.empty? ? nil: distance_of_time_in_words(Date::strptime(dob, "%m-%d-%Y"), Time.now)
    user_ret = {
      id:         user.id,
      dob:        user.dob,
      age:        age,
      name:       user.name,
      updated_at: time_ago_in_words(user.updated_at),
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
      out_response: Interest.where(user_id: current_user.id, to_user_id: user.id).first,
      shortlist:    Shortlist.where(user_id: current_user.id, to_user_id: user.id).first,
    }
    return user_ret;
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
  def for_notification

    if !defined? current_user.id
      return
    end
    @interests_notification = []
    @got_accepted_notification = []
    @got_rejected_notification = []
    @visitors_notification = []

    # today = Time.zone.now.beginning_of_day
    today = 1.week.ago
    interests    = Interest.where(to_user_id: current_user.id).where("created_at >= ?", today)
    visitors     = Visitor.where(viewed_id: current_user.id).where("updated_at >= ?", today)
    got_accepted = Interest.where(user_id: current_user.id, response: 1).where("updated_at >= ?", today)
    got_rejected = Interest.where(user_id: current_user.id, response: 0).where("updated_at >= ?", today)

    interests.each do |interest|
      @interests_notification << make_user(User.find(interest.user_id))
    end

    visitors.each do |visitor|
      @visitors_notification << make_user(User.find(visitor.user_id))
    end

    got_accepted.each do |gtr|
      @got_accepted_notification << make_user(User.find(gtr.to_user_id))
    end
    got_rejected.each do |gtr|
      @got_rejected_notification << make_user(User.find(gtr.user_id))
    end
  end
end
