class ProfilesController < ApplicationController
  before_filter :create_profile_if_not, :showing_profile_of_id
  before_filter :is_this_user_profile, only: [:edit]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    logger.debug("Debug showing_profile_of_id #{params[:id]}")
    this_user_profile = current_user.profiles.first
    logger.info("Debug Current User's id #{this_user_profile.id}")


    if !@is_owner
      if !@his_profile.visitors.first
        @his_profile.visitors.create(viewer_id: this_user_profile.id)
      else
        @his_profile.visitors.first.touch
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

  def edit
  end

  def remove
    logger.info("Debug Remove this profile")
    current_user.profiles.first.destroy
    # To Do handle session destroy & remove everything that user has
    redirect_to(profiles_path)
  end

  protected
  def create_profile_if_not
    if !current_user.profiles.first
      current_user.profiles.create()
    end
    @current_user_profile_id = @current_user.profiles.first.id
  end

  def showing_profile_of_id
    if params[:id]
      @showing_profile_of_id = params[:id]
      @his_profile = Profile.find(params[:id])
      if (@current_user_profile_id == params[:id].to_i)
        @is_owner = true
      else
        @is_owner = false
      end
    end
  end

  def is_this_user_profile
    if (@current_user_profile_id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end
end
