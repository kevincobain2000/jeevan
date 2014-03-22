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
    gon.search['profiles']  = make_gon_search(Interest.find(:all))
    render 'search'
  end

  def make_gon_search(obj)
    ret = []
    obj.each do |i|
      user = User.find(i.user_id)

      avatar = "<img src='#{user.avatar}' class='img-rounded' style='height:50px;width:50px' >"
      profile_link = "<a href='profiles/#{user.profile.id}'>#{user.name}</a>"
      dob = user[:dob].gsub("/","-")
      age = time_ago_in_words(Date::strptime(dob, "%m-%d-%Y"), Time.now)

      updated_at = "#{time_ago_in_words(user.updated_at)} ago"

      ret << [avatar, profile_link, user.religion.religion, user.kundali.birth_city, user.profile.posted_by, age, updated_at]
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
