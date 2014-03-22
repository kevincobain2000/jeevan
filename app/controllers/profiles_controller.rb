class ProfilesController < ApplicationController
  before_filter :load_gon
  before_filter :is_this_user_profile, only: [:edit]
  before_filter :get_current_user, only: [:edit]
  before_filter :get_showing_user, only: [:show]

  # GET /profiles
  def index
  end

  # GET /profiles/1
  def show
    touch_visitor
    similar_profiles
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
    render json: { :status => 200 }
  end
  def remove_image
    current_user.images.destroy(remove_image_params['imageid'])
    render json: { :status => 200 }
  end
  def modify_profile
    logger.info("Debug #{profile_params}")
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
    logger.info("Debug #{about_params}")
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
    logger.info("Debug #{desire_params}")
    current_user.desire.update(desire_params)
    render json: { :status => 200 }
  end

  # Express Interest Button
  def interest
    logger.info("Debug Params inspect #{params.inspect}")
    if current_user.id != params[:to_user_id].to_i
      find_first = current_user.interests.where(to_user_id: params[:to_user_id]).first
      logger.info("Debug Params inspect #{params.inspect}")
      if !find_first
        current_user.interests.create(to_user_id: params[:to_user_id])
      else
        find_first.touch
      end
    end
    render json: { :status => 200 }
    # redirect_to(explore_index_path)
  end

  # When accept or reject button is clicked
  def interest_response
    commit = params[:commit]
    logger.info("Debug Params inspect #{params.inspect}")
    logger.info("Debug current user id #{current_user.id}")
    interest = Interest.where(:to_user_id => current_user.id, :user_id => params[:to_user_id]).first
    logger.info("Debug Params inspect #{interest.inspect}")
    logger.info("Debug Params inspect #{current_user.interests.inspect}")
    if commit == "Accept"
      interest.update(:response => 1)
    elsif commit == "Reject"
      interest.update(:response => 0)
    end

    render json: { :status => 200 }
  end

  protected

  def load_gon
    selectize_yml_path = "#{Rails.root}/app/assets/yaml/selectize/profile/edit/items.yml"
    gon.select_profile_edit_items = YAML.load_file(selectize_yml_path)
  end

  # for editing profile
  def is_this_user_profile
    if (current_user.profile.id != params[:id].to_i)
      redirect_to(explore_index_path)
    end
  end
  def get_current_user
    @user = make_user(current_user)
  end
  def get_showing_user
    @user = make_user(User.find(Profile.find(params[:id]).user_id))
  end

  private
  def image_params
    params.permit("avatar")
  end
  def avatar_params
    params.permit(:avatar)
  end
  def remove_image_params
    params.permit("imageid")
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
    visiting_user_id = Profile.find(params[:id]).user_id
    # logger.info("Debug Touching Visitor #{visiting_user_id}")
    if current_user.id != visiting_user_id
      find_first = Visitor.where(user_id: current_user.id, viewed_id: visiting_user_id).first
      # logger.info("Debug Touching Visitor #{find_first.inspect}")
      if !find_first
        current_user.visitors.create(user_id: current_user.id, viewed_id: visiting_user_id)
      else
        find_first.touch
      end
    end
  end

  def similar_profiles
    @similar_profiles = Hash.new {|h, k| h[k] = [] }
    # Todo Take interests donot add similar_profiles to show to whom interests have been sent
    # users_not_my_gender = User.where.not(sex: current_user.sex, :id.in(@interests[:in])).order('created_at DESC').limit(1000)
    users = User.where.not(sex: current_user.sex).order('created_at DESC').limit(10)
    users.each do |user|
      @similar_profiles[user.id] = make_user(user)
    end
    @similar_profiles_paginate = @similar_profiles.keys.paginate(:page => params[:page], :per_page => 6) # 6 is a good number
  end

end
