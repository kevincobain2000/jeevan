class ProfilesController < ApplicationController
  before_filter :initialize_tables, :visiting_user_id, :load_gon
  before_filter :is_this_user_profile, only: [:edit]
  attr_accessor :profiles, :out_visitors, :in_visitors, :out_visitors,
  :in_interests, :out_interests, :visiting_user_id

  # GET /profiles
  def index
    @profiles = Profile.all
    @images = current_user.images.all
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

#-====================================
#            Edit Profile Page       =
#=====================================
  # After the save on edit is pressed
  def modify_profile
    current_user.profile.update(profile_params)
  end
  def modify_image
    @var = "Now"
    logger.info("Debug modify_images")
    logger.info("Debug Params #{params}")
    logger.info("Debug Image Params #{image_params.inspect}")
    current_user.images.create(image_params)
    render json: { :ok => true }
  end
  def modify_contact
    current_user.contact.update(contact_params)
  end
  def modify_religion
    current_user.religion.update(religion_params)
  end
  def modify_religion
    current_user.religion.update(religion_params)
  end
  def modify_kundali
    current_user.kundali.update(kundali_params)
  end
  def modify_about
    current_user.about.update(about_params)
  end
  def modify_hobby
    current_user.hobby.update(hobby_params)
  end
  def modify_family
    current_user.family.update(family_params)
  end
  def modify_education
    current_user.education.update(education_params)
  end
  def modify_lifestyle
    current_user.lifestyle.update(lifestyle_params)
  end
  def modify_desire
    current_user.desire.update(desire_params)
  end

  def edit
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
  def initialize_tables
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

  def load_gon
    selectize_json_path = "#{Rails.root}/app/assets/json/selectize/profile/edit/"
    gon.select_profile_edit_items = JSON.parse(File.read("#{selectize_json_path}items.json"))
  end

  # for editing profile
  def is_this_user_profile
    if (current_user.profile.id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end

  private
  def profile_params
    params.permit(Profile.columns.map {|c| c.name })
  end
  def image_params
    params.permit("avatar")
  end
  def contact_params
    params.permit(Contact.columns.map {|c| c.name })
  end
  def religion_params
    params.permit(Religion.columns.map {|c| c.name })
  end
  def kundali_params
    params.permit(Kundali.columns.map {|c| c.name })
  end
  def about_params
    params.permit(About.columns.map {|c| c.name })
  end
  def hobby_params
    params.permit(Hobby.columns.map {|c| c.name })
  end
  def family_params
    params.permit(Family.columns.map {|c| c.name })
  end
  def education_params
    params.permit(Education.columns.map {|c| c.name })
  end
  def lifestyle_params
    params.permit(Lifestyle.columns.map {|c| c.name })
  end
  def desire_params
    params.permit(Desire.columns.map {|c| c.name })
  end
end
