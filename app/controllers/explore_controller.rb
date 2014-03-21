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

  def search
    @searched_profiles = Hash.new {|h, k| h[k] = [] }
    # Todo Take interests donot add profiles to show to whom interests have been sent
    # users_not_my_gender = User.where.not(sex: current_user.sex, :id.in(@interests[:in])).order('created_at DESC').limit(1000)
    users = User.where.not(sex: current_user.sex).order('created_at DESC').limit(1000)
    @profiles_paginate = @searched_profiles.keys.paginate(:page => params[:page], :per_page => 4)
    users.each do |user|
      @searched_profiles[user.id] = make_user(user)
    end
    render 'search'
  end
  def show
    if params[:id] == 'search'
      search
    end
  end

  protected
  def search_params
    params.permit(:search_query)
  end
end
