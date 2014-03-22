class DashboardController < ApplicationController
  before_filter :get_current_user
  def index
    gon.dashboard = {}
    gon.dashboard['in_interests']   = make_gon_in_interests(Interest.where(to_user_id: current_user.id))
    gon.dashboard['out_interests']  = make_gon_out_interests(Interest.where(user_id: current_user.id))
    gon.dashboard['in_visitors']    = make_gon_in_visitors(Visitor.where(viewed_id: current_user.id))
  end
  def get_current_user
    @user = make_user(current_user)
  end

  def make_gon_in_visitors(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.user_id)
      ret << make_gon_array(user, 3) #response = 3 to make action button to view profile
    end
    return ret
  end
  def make_gon_out_interests(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.to_user_id)
      ret << make_gon_array(user, i.response)
    end
    return ret
  end
  def make_gon_in_interests(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.user_id)
      ret << make_gon_array(user, i.response)
    end
    return ret
  end

  def make_gon_array(user, response)
    avatar         = get_avatar_from(user.avatar)
    profile_link   = get_profile_link_from(user)
    updated_at     = get_updated_at_with_icon_from(time_ago_in_words(user.updated_at))
    age            = get_user_age_from(user.dob)
    visitors_count = get_visitors_count_from(user.visitors)
    action         = get_action_based_on(user, response)
    location       = get_location_from(user.kundali.birth_city)
    religion       = get_religion_from(user.religion.religion)
    posted_by      = get_posted_by_from(user.profile.posted_by)

    return [avatar, profile_link, religion, location, visitors_count, age, posted_by, action, updated_at]
  end

  def get_updated_at_with_icon_from(updated_at_in_words)
    if updated_at_in_words.include? "minute"
      return "<i class='fa fa-circle txt-color-green'></i> <strong>Online</strong> <small class='text-muted'>#{updated_at_in_words} ago</small>"
    else
        return "<strong>Offline</strong> <small class='text-muted'>#{updated_at_in_words} ago</small>"
    end
  end

  def get_age_from(dob)
    dob = dob.gsub("/","-")
    return "#{time_ago_in_words(Date::strptime(dob, "%m-%d-%Y"), Time.now)} old"
  end
  def get_avatar_from(avatar)
    return "<img src='#{avatar}' class='img-rounded' style='height:50px;width:50px' >"
  end
  def get_profile_link_from(user)
    return "<a href='../profiles/#{user.profile.id}'>#{user.name}</a>"
  end
  def get_action_based_on(user, response)
    if response.nil?
      action = "<a href='../profiles/#{user.profile.id}' class='label label-info'><i class='fa fa-check'></i> Interested</a>"
    end
    if response == 0
      action = "<a href='../profiles/#{user.profile.id}' class='label label-danger'><i class='fa fa-times'></i> Not Accepted</a>"
    end
    if response == 1
      action = "<a href='../profiles/#{user.profile.id}' class='label label-success'><i class='fa fa-check'></i> Accepted !</a>"
    end
    if response == 3
      action = "<a href='../profiles/#{user.profile.id}' class='label label-default'><i class='fa fa-eye'></i> View Profile</a>"
    end
    return action
  end
  def get_user_age_from(dob)
    db = dob.gsub("/","-")
    age = dob.empty? ? nil: distance_of_time_in_words(Date::strptime(db, "%m-%d-%Y"), Time.now)
    return "<strong class='txt-color-green'>#{age}</strong><small class='text-muted'> old</small>"
  end
  def get_visitors_count_from(visitors)
    return "#{visitors.count}<small class='text-muted'> visitors</small>"
  end
  def get_location_from(birth_city)
    return "<strong>#{birth_city}</strong>"
  end
  def get_religion_from(religion)
    return "<strong class='txt-color-green'>#{religion}</strong>"
  end
  def get_posted_by_from(posted_by)
    return "<strong class='txt-color-blue'>#{posted_by}</strong>"
  end

end
