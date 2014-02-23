class VisitorsController < ApplicationController
  def index
    @profiles = Hash.new()

    if visitors_params[:format] == "in"
      visitors_ids = Visitor.where(viewed_id: current_user.id).pluck(:user_id)
    elsif visitors_params[:format] == "out"
      visitors_ids = Visitor.where(user_id: current_user.id).pluck(:viewed_id)
    end
    users = User.find(visitors_ids)
    users.each do |user|
      @profiles[user.id] = {profile: user.profile, avatar: user.avatar}
    end
    @profiles_paginate = @profiles.keys.paginate(:page => params[:page], :per_page => 4)
  end

  private
  def visitors_params
    params.permit(["format"])
  end
end
