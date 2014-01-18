class ProfilesController < ApplicationController
  before_filter :create_profile_if_not, :showing_profile_of_id
  before_filter :is_this_user_profile, only: [:edit]

  # GET /profiles
  def index
    @profiles = Profile.all
    @my_visitors = @current_user_profile.visitors
    @my_interests = current_user.interests
  end

  # GET /profiles/1
  def show
    find_first = current_user.profiles.first
    if !@is_owner
      if !@his_profile.visitors.first
        @his_profile.visitors.create(viewer_id: find_first.id)
      else
        find_first.touch
      end
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  def modify
    current_user.profiles.first.update(:sex => params['sex'])
    # To do change to /profile/:this id/path
    redirect_to(profiles_path)
  end

  def remove
    current_user.profiles.first.destroy
    redirect_to(profiles_path)
  end

  def interest
    find_first = current_user.interests.first
    if !find_first
      current_user.interests.create(to_user_id: params[:to_user_id])
    else
      find_first.touch
    end
    redirect_to(profiles_path)
  end

  protected
  def create_profile_if_not
    if !current_user.profiles.first
      current_user.profiles.create()
    end

    @current_user_profile = @current_user.profiles.first
    if (@current_user_profile.id == params[:id].to_i)
      @is_owner = true
    else
      @is_owner = false
    end
  end

  def showing_profile_of_id
    if params[:id]
      @showing_profile_of_id = params[:id]
      @his_profile = Profile.find(params[:id])
    end
  end

  def is_this_user_profile
    if (@current_user_profile.id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end
end
