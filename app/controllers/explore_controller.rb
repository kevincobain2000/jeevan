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
    gon.search = {}
    gon.search['profiles']  = make_gon_search(Profile.find(:all))
    render 'search'
  end

  def make_gon_search(obj)
    ret = []
    dashboard_methods = DashboardController.new
    obj.each do |i|
      user = User.find(i.user_id)

      avatar         = dashboard_methods.get_avatar_from(user.avatar)
      profile_link   = dashboard_methods.get_profile_link_from(user)
      religion       = dashboard_methods.get_religion_from(user.religion.religion)
      location       = dashboard_methods.get_location_from(user.kundali.birth_city)
      visitors_count = dashboard_methods.get_visitors_count_from(user.visitors)
      posted_by      = dashboard_methods.get_posted_by_from(user.profile.posted_by)
      age            = dashboard_methods.get_user_age_from(user.dob)
      updated_at     = dashboard_methods.get_updated_at_with_icon_from(time_ago_in_words(user.updated_at))
      action         = dashboard_methods.get_action_based_on(user, 3)

      ret << [avatar, profile_link, religion, location, visitors_count, posted_by, age, action, updated_at]
    end
    return ret
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
