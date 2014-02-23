class VisitorsController < ApplicationController
  def index
    @profiles = Hash.new()
    visitors_ids = Visitor.where(viewed_id: current_user.id).pluck(:user_id)
    users = User.find(visitors_ids)
    users.each do |user|
      logger.info("Debug #{user}")
      @profiles[user.id] = {profile: user.profile, avatar: user.avatar}
    end
    @profiles_paginate = @profiles.keys.paginate(:page => params[:page], :per_page => 4)
  end
end
