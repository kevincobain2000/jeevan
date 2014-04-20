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
  layout :dirty_layout_hack
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # protect_from_forgery with: :null_session

  def make_user(user)
    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first

    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "name upon acceptance"

    user_ret = {
      id:         user.id,
      dob:        user.dob,
      age:        age,
      name:       titleize(truncate(name)),
      updated_at: time_ago_in_words(user.updated_at),
      sex:        titleize(user.sex),
      visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
      profile:    user.profile,
      contact:    user.contact,
      about:      user.about,
      religion:   user.religion,
      devotion:   user.devotion,
      kundali:    user.kundali,
      family:     user.family,
      hobby:      user.hobby,
      education:  user.education,
      lifestyle:  user.lifestyle,
      desire:     user.desire,
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
    # notifications = current_user.notifications().where("created_at >= ?", 1.week.ago).order(:seen, :created_at)
    notifications = Notification.where(to_user_id: current_user.id).where("created_at >= ?", 1.week.ago).order(:seen, :created_at)
    notifications.each do |notification|
      __user = User.find(notification.user_id)
      user = {}
      user[:avatar]     = __user.avatar
      user[:name]       = titleize(__user.name)
      user[:profile]    = __user.profile
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

  def dirty_layout_hack
    if controller_name == "registrations" && action_name == "edit"
      return false
    end
  end
  def record_not_found
    redirect_to root_path
  end
end