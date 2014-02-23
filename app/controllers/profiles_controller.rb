require 'will_paginate/array'
class ProfilesController < ApplicationController
  before_filter :initialize_tables, :load_gon
  before_filter :is_this_user_profile, only: [:edit]
  before_filter :get_current_user, only: [:edit]
  before_filter :get_showing_user, only: [:show]

  # GET /profiles
  def index
    @interests = {in: Interest.where(to_user_id: current_user.id), responses: Interest.where(user_id: current_user.id)}

    @profiles = Hash.new()
    # Todo Take interests donot add profiles to show to whom interests have been sent
    # users_not_my_gender = User.where.not(sex: current_user.sex, :id.in(@interests[:in])).order('created_at DESC').limit(1000)
    users = User.where.not(sex: current_user.sex).order('created_at DESC').limit(1000)

    users.each do |user|
      @profiles[user.id] = {profile: user.profile, avatar: user.avatar}
    end

    @profiles_paginate = @profiles.keys.paginate(:page => params[:page], :per_page => 4)
    @visitors = {out: current_user.visitors, in:Visitor.where(viewed_id: current_user.id)}
  end

  # GET /profiles/1
  def show
    touch_visitor
  end
  def edit

  end

#-====================================
#            Edit Profile Page       =
#=====================================
  # After the save on edit is pressed
  def modify_image
    current_user.images.create(image_params)
    render json: { :status => 200 }
  end
  def modify_avatar
    current_user.update(avatar_params)
    redirect_to :back
  end
  def remove_image
    all_images_ids = current_user.images.pluck(:id)
    not_to_remove_ids = []
    remove_image_params.each do |param, value|
        if !!(param =~ /^[-+]?[0-9]+$/) && !!(value =~ /^[-+]?[0-9]+$/) #if number
          not_to_remove_ids.push(value.to_i)
        end
    end
    remove_id = all_images_ids - not_to_remove_ids
    current_user.images.destroy(remove_id[0])
    render json: { :status => 200 }
  end
  def modify_profile
    current_user.profile.update(profile_params)
    render json: { :status => 200 }
  end
  def modify_contact
    current_user.contact.update(contact_params)
    render json: { :status => 200 }
  end
  def modify_religion
    current_user.religion.update(religion_params)
    render json: { :status => 200 }
  end
  def modify_kundali
    current_user.kundali.update(kundali_params)
    render json: { :status => 200 }
  end
  def modify_about
    current_user.about.update(about_params)
    render json: { :status => 200 }
  end
  def modify_hobby
    current_user.hobby.update(hobby_params)
    render json: { :status => 200 }
  end
  def modify_family
    current_user.family.update(family_params)
    render json: { :status => 200 }
  end
  def modify_education
    current_user.education.update(education_params)
    render json: { :status => 200 }
  end
  def modify_lifestyle
    current_user.lifestyle.update(lifestyle_params)
    render json: { :status => 200 }
  end
  def modify_desire
    current_user.desire.update(desire_params)
    render json: { :status => 200 }
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
    current_user.profile    = Profile.find_or_initialize_by(user_id: current_user.id, sex:current_user.sex)
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

  def load_gon
    selectize_yml_path = "#{Rails.root}/app/assets/yaml/selectize/profile/edit/items.yml"
    gon.select_profile_edit_items = YAML.load_file(selectize_yml_path)
  end

  # for editing profile
  def is_this_user_profile
    if (current_user.profile.id != params[:id].to_i)
      redirect_to(profiles_path)
    end
  end
  def get_current_user
    @user = {}
    @user[:profile]   = current_user.profile
    @user[:contact]   = current_user.contact
    @user[:about]     = current_user.about
    @user[:religion]  = current_user.religion
    @user[:kundali]   = current_user.kundali
    @user[:family]    = current_user.family
    @user[:hobby]     = current_user.hobby
    @user[:education] = current_user.education
    @user[:lifestyle] = current_user.lifestyle
    @user[:desire]    = current_user.desire
    @user[:image]     = current_user.images.all
  end
  def get_showing_user
    logger.info("Debug #{params.inspect}")
    user = User.find(Profile.find(params[:id]).user_id)
    @user = {}
    @user[:profile]   = user.profile
    @user[:contact]   = user.contact
    @user[:about]     = user.about
    @user[:religion]  = user.religion
    @user[:kundali]   = user.kundali
    @user[:family]    = user.family
    @user[:hobby]     = user.hobby
    @user[:education] = user.education
    @user[:lifestyle] = user.lifestyle
    @user[:desire]    = user.desire
    @user[:image]     = user.images.all
  end


  private
  def image_params
    params.permit("avatar")
  end
  def avatar_params
    params.permit(:avatar)
  end
  def remove_image_params
    params.permit!
  end
  def profile_params
    params.permit(Profile.columns.map {|c| c.name })
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

#===============================================*
#            This Class's Helpers
#===============================================*
  def touch_visitor
    logger.info("Debug Touching Visitor")
    visitors_id = params[:id]
    if current_user.id != visitors_id.to_i
      find_first = current_user.visitors.where(viewed_id: visitors_id).first
      if !find_first
        current_user.visitors.create(viewed_id: visitors_id)
      else
        find_first.touch
      end
    end
  end

end
