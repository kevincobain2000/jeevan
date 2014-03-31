require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :do_notifications
  protect_from_forgery with: :exception
  after_filter :user_activity
  helper_method :make_user
  # protect_from_forgery with: :null_session

  def make_user(user)
    dob = user.dob.gsub("/","-")
    age = user.dob.empty? ? nil: distance_of_time_in_words(Date::strptime(dob, "%m-%d-%Y"), Time.now)
    user_ret = {
      id:         user.id,
      dob:        user.dob,
      age:        age,
      name:       titleize(truncate(user.name)),
      updated_at: time_ago_in_words(user.updated_at),
      sex:        titleize(user.sex),
      visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
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

  # flag = 0 visited Profile
  # flag = 1 expressed Interest
  # flag = 2 accepted Interest
  # flag = 3 rejected Interest
  def do_notifications
    if !defined? current_user.id
      return
    end
    messages = [ ["Viewed Your Profile", "fa fa-eye"], ["Expressed Interest !", "fa fa-connect"], ["Accepted Interest !", "fa fa-check"], ["Rejected Interest", "fa fa-times"] ]
    @notifications = Hash.new {|h, k| h[k] = [] }
    @notifications_unread_count = 0
    notifications = current_user.notifications().where("created_at >= ?", 1.week.ago).order(:seen, :created_at)
    notifications.each do |notification|
      __user = User.find(notification.to_user_id)
      user = {}
      user[:avatar]     = __user.avatar
      user[:name]       = titleize(__user.name)
      user[:profile]    = __user.profile
      # user[:updated_at] = time_ago_in_words(__user.updated_at)
      user[:message]    = messages[notification.flag][0]
      user[:icon]       = messages[notification.flag][1]
      user[:seen]       = notification.seen
      user[:created_at] = time_ago_in_words(notification.created_at)
      @notifications[notification.id] = user

      if notification.seen.nil?
        @notifications_unread_count += 1
      end
    end
  end
end







