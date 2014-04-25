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
    # users = User.where.not(sex: current_user.sex).where(devotion: current_user.devotion).order('avatar_updated_at DESC').limit(100)
    # users.each do |user|
    #   @profiles_matches[user.id] = make_user(user)
    # end
    # @profiles_paginate_matches = @profiles_matches.keys.paginate(:page => params[:matches], :per_page => 7)
    @profiles_paginate_matches = User.paginate(:page => params[:page], :per_page => 10)
    # search
  end

  def show
  end

  protected
  def search_params
    params.permit(:search_query)
  end
end
