class ProfilesController < ApplicationController
  before_filter :create_profile_if_not, :visiting_user_id
  before_filter :is_this_user_profile, only: [:edit]
  attr_accessor :profiles, :out_visitors, :in_visitors, :out_visitors,
  :in_interests, :out_interests, :visiting_user_id

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
    @showing_user = Profile.where(:user_id => params[:id])
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
  def modify_profile
    # Filter, remove devise keys like utf8, authenticiy_token etcc
    incoming_form_params = Profile.columns.map {|c| c.name } & params.keys
    with_data = {}
    incoming_form_params.each do |param_key|
      with_data[param_key] = params[param_key]
    end
    #save all params coming in from the form
    current_user.profile.update(with_data)
    redirect_to :back
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
    current_user.profile    = Profile.find_or_initialize_by(user_id: current_user.id)
    current_user.contact    = Contact.find_or_initialize_by(user_id: current_user.id)
    current_user.religion   = Religion.find_or_initialize_by(user_id: current_user.id)
    current_user.kundali    = Kundali.find_or_initialize_by(user_id: current_user.id)
    current_user.about      = About.find_or_initialize_by(user_id: current_user.id)
    current_user.family     = Family.find_or_initialize_by(user_id: current_user.id)
    current_user.desire     = Desire.find_or_initialize_by(user_id: current_user.id)
    current_user.education  = Education.find_or_initialize_by(user_id: current_user.id)
    current_user.hobby      = Hobby.find_or_initialize_by(user_id: current_user.id)
    current_user.lifestyle  = Lifestyle.find_or_initialize_by(user_id: current_user.id)
    current_user.occupation = Occupation.find_or_initialize_by(user_id: current_user.id)
  end

  def visiting_user_id
    if params[:id]
      @visiting_user_id = Profile.find(params[:id]).user_id
    end
  end

  # for editing profile
  def is_this_user_profile
    if (current_user.profile.id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end
end
