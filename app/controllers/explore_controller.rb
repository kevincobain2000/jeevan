class ExploreController < ApplicationController
  def index
    @profiles = Hash.new {|h, k| h[k] = [] }
    # Todo Take interests donot add profiles to show to whom interests have been sent
    # users_not_my_gender = User.where.not(sex: current_user.sex, :id.in(@interests[:in])).order('created_at DESC').limit(1000)
    users = User.where.not(sex: current_user.sex).order('created_at DESC').limit(1000)
    users.each do |user|
      @profiles[user.id] = make_user(user)
    end
    @profiles_paginate = @profiles.keys.paginate(:page => params[:page], :per_page => 4)
  end
end
