class ProfilesController < ApplicationController
  before_filter :create_profile_if_not, :visiting_user_id
  before_filter :is_this_user_profile, only: [:edit]
  attr_accessor :profiles, :out_visitors, :in_visitors, :out_visitors,
  :in_interests, :out_interests, :is_owner, :current_user_profile, :visiting_user_id

  # GET /profiles
  def index
    @profiles = Profile.all
    @out_visitors = current_user.visitors
    @in_visitors = Visitor.where(viewed_id: current_user.id)

    @in_interests = Interest.where(to_user_id: current_user.id)
    @out_interests_responses = Interest.where(user_id: current_user.id)
  end

  # GET /profiles/1
  def show
    if current_user.id != @visiting_user_id.to_i
      find_first = current_user.visitors.where(viewed_id: @visiting_user_id).first
      if !find_first
        current_user.visitors.create(viewed_id: @visiting_user_id)
      else
        find_first.touch
      end
    end
  end

  # After the edit is pressed
  def modify
    current_user.profiles.first.update(:sex => params['sex'])
    redirect_to(profiles_path)
  end

  # Delete this Profile Button
  def remove
    current_user.destroy
    redirect_to(profiles_path)
  end

  # Express Interest Button
  def interest
    if current_user.id != params[:to_user_id].to_i
      find_first = current_user.interests.where(to_user_id: params[:to_user_id]).first
      logger.info("Debug Params inspect #{params.inspect}")
      if !find_first
        current_user.interests.create(to_user_id: params[:to_user_id])
      else
        find_first.touch
      end
    end
    redirect_to(profiles_path)
  end

  # When accept or reject button is clicked
  def interest_response
    commit = params[:commit]

    interest = User.find(params[:from_user_id]).interests.where(:to_user_id => current_user.id).first

    if commit == "Accept"
      interest.update(:response => 1)
    else
      interest.update(:response => 0)
    end

    redirect_to(profiles_path)
  end

  protected
  def create_profile_if_not
    if !current_user.profiles.first
      current_user.profiles.create()
    end
    @current_user_profile = @current_user.profiles.first
    @is_owner = (@current_user_profile.id == params[:id].to_i) ? true : false
  end

  def visiting_user_id
    if params[:id]
      @visiting_user_id = Profile.find(params[:id]).user_id
    end
  end

  # for editing profile
  def is_this_user_profile
    if (@current_user_profile.id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end
end
