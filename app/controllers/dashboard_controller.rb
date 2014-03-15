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
      logger.info("Debug #{user.profile.id}")
      av = "<img src='#{user.avatar}' style='height:50px;width:50px' >"
      pl = "<a href='profiles/#{user.profile.id}'>Show</a>"
      ret << [av, i.user_id, pl, "#{time_ago_in_words(i.created_at)} ago"]
    end
    return ret
  end

end
