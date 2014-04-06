class ExploreController < ApplicationController

  /#=====================================================
  #Basic search criteria for the user on the explore page
  #======================================================/

  def index
    #-----  Recently joined  ------
    @profiles_joined_recently = Hash.new {|h, k| h[k] = [] }
    users = User.where.not(sex: current_user.sex).where('created_at >= ?', 1.week.ago).limit(1000)
    users.each do |user|
      @profiles_joined_recently[user.id] = make_user(user)
    end
    @profiles_paginate_joined_recently = @profiles_joined_recently.keys.paginate(:page => params[:joined], :per_page => 4)

    #-----  Matches  ------
    @profiles_matches = Hash.new {|h, k| h[k] = [] }
    users = User.where.not(sex: current_user.sex).order('updated_at DESC').limit(1000)
    users.each do |user|
      @profiles_matches[user.id] = make_user(user)
    end
    @profiles_paginate_matches = @profiles_matches.keys.paginate(:page => params[:matches], :per_page => 4)

    #-----  Visitors  ------
    @profiles_visitors = Hash.new {|h, k| h[k] = [] }
    visitors_ids  = Visitor.where(viewed_id: current_user.id).where("updated_at >= ?", 1.week.ago).limit(1000).pluck(:user_id).uniq
    users = User.find(visitors_ids)
    users.each do |user|
      @profiles_visitors[user.id] = make_user(user)
    end
    @profiles_paginate_visitors = @profiles_visitors.keys.paginate(:page => params[:visitors], :per_page => 4)

  end

  def search
    gon.search = {}
    # users_ids = User.where.not(sex: current_user.sex).limit(3000).pluck(:id)
    users_ids = User.where(sex: current_user.sex).limit(3000).pluck(:id)
    gon.search['profiles']  = make_gon_search(Profile.find(users_ids))
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

      ret << [avatar, profile_link, religion, location, visitors_count, age, posted_by, action, updated_at]
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
