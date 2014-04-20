class ExploreController < ApplicationController

  /#=====================================================
  #Basic search criteria for the user on the explore page
  #======================================================/

 
  def index
    # Currently the search results are shown as datatables. The other way is to use will_paginate. 
    # If want to do will_paginate way then uncomment the following Matches and comment the bottom search
    # Experiment if the datatables are able to handle 10000 records

    #-----  Matches  ------
    # @profiles_matches = Hash.new {|h, k| h[k] = [] }
    # users = User.where.not(sex: current_user.sex).where(devotion: current_user.devotion).order('avatar_updated_at DESC').limit(1000)
    # users.each do |user|
    #   @profiles_matches[user.id] = make_user(user)
    # end
    # @profiles_paginate_matches = @profiles_matches.keys.paginate(:page => params[:matches], :per_page => 7)

    search
  end

  def search
    gon.search = {}
    # users_ids = User.where.not(sex: current_user.sex).limit(3000).pluck(:id)
    users_ids = User.where.not(sex: current_user.sex).where(devotion: current_user.devotion).order('created_at DESC').limit(10000).pluck(:id)
    gon.search['query'] = params[:query] ? params[:query] : "";
    @search_profiles = make_gon_search(Profile.find(users_ids))
    render 'search'
  end

  def make_gon_search(obj)
    ret = []
    dashboard_methods = DashboardController.new
    obj.each do |i|
      user = User.find(i.user_id)
      ret << make_user(user)
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
