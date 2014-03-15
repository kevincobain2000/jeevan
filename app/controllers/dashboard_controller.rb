class DashboardController < ApplicationController
  before_filter :get_current_user
  def index
    @interests = {in: Interest.where(to_user_id: current_user.id), responses: Interest.where(user_id: current_user.id)}
    @visitors = {out: current_user.visitors, in:Visitor.where(viewed_id: current_user.id)}

    gon.dashboard = {}
    gon.dashboard['in_interests']   = make_gon_in_interests(Interest.where(to_user_id: current_user.id))
    gon.dashboard['out_interests']  = make_gon_out_interests(Interest.where(user_id: current_user.id))
    gon.dashboard['in_visitors']    = make_gon_in_visitors(Visitor.where(viewed_id: current_user.id))
  end
  def get_current_user
    @user = make_user(current_user)
  end

  private
  def make_gon_in_visitors(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.user_id)

      avatar = "<img src='#{user.avatar}' class='img-rounded' style='height:50px;width:50px' >"
      profile_link = "<a href='profiles/#{user.profile.id}'>#{user.name}</a>"
      dob = user[:dob].gsub("/","-")
      age = time_ago_in_words(Date::strptime(dob, "%d-%m-%Y"), Time.now)

      updated_at = "#{time_ago_in_words(user.updated_at)} ago"

      ret << [avatar, profile_link, user.religion.religion, user.kundali.birth_city, user.profile.posted_by, age, updated_at]
    end
    return ret
  end
  def make_gon_out_interests(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.to_user_id)

      avatar = "<img src='#{user.avatar}' class='img-rounded' style='height:50px;width:50px' >"
      profile_link = "<a href='profiles/#{user.profile.id}'>#{user.name}</a>"
      dob = user[:dob].gsub("/","-")
      updated_at = "#{time_ago_in_words(user.updated_at)} ago"

      updated_at = "#{time_ago_in_words(user.updated_at)} ago"
      if i.response.nil?
        action = '<span class="label label-success">Waiting for response</span>'
      end
      if i.response == 0
        action = '<span class="label label-warning">Not Interested</span>'
      end
      if i.response == 1
        action = '<span class="label label-success">Interested !</span>'
      end
      ret << [avatar, profile_link, user.religion.religion, user.kundali.birth_city, user.profile.posted_by, updated_at, action]
    end
    return ret
  end
  def make_gon_in_interests(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.user_id)

      avatar = "<img src='#{user.avatar}' class='img-rounded' style='height:50px;width:50px' >"
      profile_link = "<a href='profiles/#{user.profile.id}'>#{user.name}</a>"
      dob = user[:dob].gsub("/","-")
      updated_at = "#{time_ago_in_words(user.updated_at)} ago"

      updated_at = "#{time_ago_in_words(user.updated_at)} ago"
      if i.response.nil?
        action = "<a href='profiles/#{user.profile.id}'>Respond to #{user.name}</a>"
      end
      if i.response == 0
        action = '<span class="label label-warning">You have responded as Not Interested</span>'
      end
      if i.response == 1
        action = '<span class="label label-success">You have Accepted</span>'
      end
      ret << [avatar, profile_link, user.religion.religion, user.kundali.birth_city, user.profile.posted_by, updated_at, action]
    end
    return ret
  end

end
