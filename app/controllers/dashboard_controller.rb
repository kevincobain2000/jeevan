class DashboardController < ApplicationController
  before_filter :get_current_user
  def index
    @interests = {in: Interest.where(to_user_id: current_user.id), responses: Interest.where(user_id: current_user.id)}
    @visitors = {out: current_user.visitors, in:Visitor.where(viewed_id: current_user.id)}

    gon.inv = make_gon(Interest.where(user_id: current_user.id))
  end
  def get_current_user
    @user = make_user(current_user)
  end

  private
  def make_gon(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.id)

      avatar = "<img src='#{user.avatar}' class='img-rounded' style='height:50px;width:50px' >"
      profile_link = "<a href='profiles/#{user.profile.id}'>Show</a>"
      updated_at = "#{time_ago_in_words(user.updated_at)} ago"

      # dob = dob.gsub("/","-")
      # age = distance_of_time_in_words(Date::strptime(dob, "%d-%m-%Y"), Time.now) : ""

      ret << [avatar, profile_link, user.religion, user.kundali.birth_city,user.profile.posted_by, updated_at]
    end
    return ret
  end

end
