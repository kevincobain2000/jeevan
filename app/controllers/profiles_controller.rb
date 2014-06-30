class ProfilesController < ApplicationController
  before_filter :has_sex, except: [:modify_avatar]
  before_filter :is_this_user_profile, only: [:edit]
  before_filter :not_same_sex, :get_showing_user, only: [:show]

  PAGINATE_PROFILES = 30
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
    upload_limit = 20
    if current_user.images.count > upload_limit
      response =  { :error => "Sorry, Limit is #{upload_limit} images", :status => 422 }
    else
      response = {:status => 200}
      current_user.images.create(image_params)
      current_user.update(:images_count => current_user.images.count)
    end
    render json: response
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
    current_user.profile.update(profile_params)
    render json: { :status => 200 }
  end
  def modify_contact
    current_user.contact.update(contact_params)
    render json: { :status => 200 }
  end
  def modify_religion
    current_user.religion.update(religion_params)
    if params[:religion]
      current_user.update(:devotion => params[:religion])
    end
    render json: { :status => 200 }
  end
  def modify_kundali
    if params[:dob]
      current_user.update(:dob => params[:dob])
    end
    current_user.kundali.update(kundali_params)
    render json: { :status => 200 }
  end
  def modify_about
    text = about_params[:me].split()
    text.each do |word| 
      if word.length > 50
        # Donot save
        render json: { :status => 200 }
      end
    end
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
  def modify_occupation
    current_user.occupation.update(occupation_params)
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
  def destroy_everything
    user = User.find(current_user.id)
    user.destroy
    Interest.where(:to_user_id => current_user.id).destroy_all
    Visitor.where(:viewed_id => current_user.id).destroy_all
    Shortlist.where(:to_user_id => current_user.id).destroy_all
    Message.where(:to_user_id => current_user.id).destroy_all
    redirect_to root_path
  end

  /#=================================================
  #            # Express Interest Button            =
  #=================================================*/

  def interest
    if current_user.id != params[:to_user_id].to_i
      find_first = current_user.interests.where(to_user_id: params[:to_user_id]).first
      if !find_first
        current_user.interests.create(to_user_id: params[:to_user_id])
        notify_growl(:interest, params[:to_user_id], "Expressed Interest in You", true)
      else
        find_first.touch
      end
    end
    render json: { :status => 200 }
  end


  /#=================================================
  #            Accept Reject Button is Pressed      =
  #=================================================*/

  def interest_response
    commit = params[:commit]
    interest = Interest.where(:to_user_id => current_user.id, :user_id => params[:to_user_id]).first
    if commit == "Accept"
      interest.update(:response => 1)
      notify_growl(:accepted, params[:to_user_id], "Accepted Your Interest", true)
    elsif commit == "Reject"
      interest.update(:response => 0)
      notify_growl(:rejected, params[:to_user_id], "Rejected Your Interest", true)
    end

    render json: { :status => 200 }
  end

  def shortlist
    if current_user.id != params[:to_user_id].to_i
      find_first = current_user.shortlists.where(to_user_id: params[:to_user_id]).first
      if !find_first
        current_user.shortlists.create(to_user_id: params[:to_user_id])
      end
    end
    render json: { :status => 200 }
  end

  #==================================
  #            Ajax Calls
  #==================================


  def get_selectize
    selectize_yml_path = "#{Rails.root}/app/assets/yaml/selectize/profile/edit/items.yml"
    select_profile_edit_items = YAML.load_file(selectize_yml_path)
    render json: { :data => select_profile_edit_items }
  end
  #-----  End of Ajax Calls  ------#

  /#=============================
  #            Pages            =
  #==============================#/
  def index
    already_visited    = [current_user.id]
    lookup_sex = current_user.sex == "Male" ? "Female" : "Male"
    # already_visited   += Visitor.where(user_id: current_user.id).pluck(:viewed_id)
    # already_visited   += Interest.where("user_id = ?", current_user.id).pluck(:to_user_id)
    # already_visited   += Shortlist.where("user_id = ?", current_user.id).pluck(:to_user_id)
    @matching = User.where("sex = ? AND id NOT IN (?)", lookup_sex, already_visited).order('images_count DESC, avatar_file_size DESC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def online
    already_visited    = [current_user.id]
    lookup_sex = current_user.sex == "Male" ? "Female" : "Male"
    @online = User.where("sex = ? AND id NOT IN (?) AND updated_at >= ?", lookup_sex, already_visited, 30.minutes.ago).order('updated_at ASC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
  end
  def withphotos
    already_visited    = [current_user.id]
    lookup_sex = current_user.sex == "Male" ? "Female" : "Male"
    @withphotos = User.where("sex = ? AND id NOT IN (?) AND images_count >= ?", lookup_sex, already_visited, 1).order('images_count DESC, avatar_updated_at DESC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
  end
  def recentlyjoined
    already_visited    = [current_user.id]
    lookup_sex = current_user.sex == "Male" ? "Female" : "Male"
    @recentlyjoined = User.where("sex = ? AND id NOT IN (?) AND created_at >= ?", lookup_sex, already_visited, Time.zone.now.beginning_of_day).order('created_at DESC, avatar_updated_at DESC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
  end

  def incomings
    incomings = Interest.where(to_user_id: current_user.id).order("updated_at DESC").pluck(:user_id)
    @incomings = User.find(incomings, :order => "field(id,#{incomings.join(',')})").paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
    badge_reset(current_user, "interest")
  end
  def accepted
    accepted = Interest.where("user_id = ? AND response = ?", current_user.id, 1).order("updated_at DESC").pluck(:to_user_id)
    @accepted = User.find(accepted, :order => "field(id,#{accepted.join(',')})").paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
    badge_reset(current_user, "accepted")
  end
  def outgoings
    rejected = Interest.where("user_id = ? AND response = ?", current_user.id, 0).order("updated_at DESC").pluck(:to_user_id)
    @rejected = User.find(rejected, :order => "field(id,#{rejected.join(',')})").paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
    badge_reset(current_user, "rejected")
  end
  def visitors
    visitors = Visitor.where(viewed_id: current_user.id).order("updated_at DESC").pluck(:user_id)
    @visitors = User.find(visitors, :order => "field(id,#{visitors.join(',')})").paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
    badge_reset(current_user, "visitor")
  end
  def waiting
    waiting = Interest.where("user_id = ? AND response IS NULL", current_user.id).order("updated_at DESC").pluck(:to_user_id)
    @waiting = User.find(waiting, :order => "field(id,#{waiting.join(',')})").paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
  end
  def shortlists
    shortlists = Shortlist.where(user_id: current_user.id).pluck(:to_user_id)
    @shortlists = User.find(shortlists).paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
  end

  def search
    query_string = params[:query].to_s
    probably_age = query_string.scan(/\d+/).first
    if probably_age && probably_age.length == 2 && probably_age.to_i >= 18
      year_will_be_searching = Time.now.year - probably_age.to_i
      query_string = query_string.gsub(probably_age, "")
      query_string += "#{year_will_be_searching.to_s}"
    end

    query_string = query_string.length > 0 ? query_string : current_user.devotion
    @solr = User.search do
      fulltext query_string
      without(:sex).equal_to(current_user.sex)
      without(:sex).equal_to("Unknown")
      without(:dob).equal_to("01/01/1900")
      order_by(:images_count, :desc)
      paginate :page => params[:page], :per_page => PAGINATE_PROFILES
    end
    @search = @solr.results
    @query_was = params[:query]
  end

  def search_advanced
    ages = params[:asearch_age].gsub(/Yrs/, '').split("-").map{|j| j.strip()}.map{|yrs| Time.now.year - yrs.to_i}.sort
    from_dob = "01/01/#{ages[0]}"
    to_dob = "31/12/#{ages[1]}"

    home_q = params[:asearch_home]
    religion_q = params[:asearch_religion]
    caste_q = params[:asearch_caste]
    marital_status_q = "#{params[:asearch_single]} #{params[:asearch_widowed]} #{params[:asearch_divorced]}"
    manglik_q = params[:asearch_manglik] == "on" ? "Yes" : "No"

    the_query = "#{religion_q} #{caste_q} #{marital_status_q}"
    @solr = User.search do
      fulltext the_query
      without(:sex).equal_to(current_user.sex)
      without(:sex).equal_to("Unknown")
      with(:manglik).equal_to(manglik_q)
      order_by(:images_count, :desc)
      paginate :page => params[:page], :per_page => PAGINATE_PROFILES
    end
    @search = @solr.results
    render "search"
  end


  def similar_profiles
    visiting_user = User.find(Profile.find(params[:id]).user_id)
    if current_user.id == visiting_user.id
      already_visited = [current_user.id]
      lookup_sex = current_user.sex == "Male" ? "Female" : "Male"
      @similar_profiles_paginate = User.where("sex = ? AND id NOT IN (?)", lookup_sex, already_visited).order('images_count DESC, avatar_updated_at DESC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES)
      else
        @similar_profiles_paginate = User.where("id <> ? AND sex = ?", visiting_user.id, visiting_user.sex).order('updated_at DESC, avatar_updated_at DESC').take(12).paginate(:page => params[:page], :per_page => 6) # 6 is a good number
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  #-----  End of Pages  -----#
  def count_sparks
    # @sparks = Hash.new {|h, k| h[k] = [] }
    # @sparks[:visitors]  = number_with_delimiter(Visitor.where(viewed_id: current_user.id).count)
    # @sparks[:incoming]  = number_with_delimiter(Interest.where(to_user_id: current_user.id).count)
    # @sparks[:rejected]  = number_with_delimiter(Interest.where("user_id = ? AND response = ?", current_user.id, 0).count)
    # @sparks[:waiting]   = number_with_delimiter(Interest.where("user_id = ? AND response IS NULL", current_user.id).count)
    # @sparks[:shortlist] = number_with_delimiter(Shortlist.where(user_id: current_user.id).count)
    # @sparks[:accepted]  = number_with_delimiter(Interest.where("user_id = ? AND response = ?", current_user.id, 1).count)
    # @sparks[:onlinenow]  = User.where("sex <> ? AND updated_at >= ?", current_user.sex, 30.minutes.ago).count
    # @sparks[:withphotos]  = User.where("sex <> ? AND images_count >= ?", current_user.sex, 1).order('images_count DESC, avatar_updated_at DESC').paginate(:page => params[:page], :per_page => PAGINATE_PROFILES).count
    # @sparks[:recentlyjoined]  = User.where("sex <> ? AND created_at >= ?", current_user.sex, Time.zone.now.beginning_of_day).count
  end

  protected

  # for editing profile
  def is_this_user_profile
    if (current_user.profile.id != params[:id].to_i)
      redirect_to root_path
    end
  end

  def get_showing_user
    # @user = make_user(User.find(Profile.find(params[:id]).user_id))
    @user = User.find(Profile.find(params[:id]).user_id)
  end
  def not_same_sex
    user = User.find(Profile.find(params[:id]).user_id)
    if (user.id != current_user.id && current_user.sex == user.sex) || (user.sex.to_s == "Unknown")
      redirect_to root_path
    end
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
  def occupation_params
    params.permit(Occupation.columns.map {|c| c.name })
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
    if current_user.id != visiting_user_id
      visitor = Visitor.where(user_id: current_user.id, viewed_id: visiting_user_id).first
      if !visitor
        visitor_created = Visitor.find_or_create_by(user_id: current_user.id, viewed_id: visiting_user_id)
        notify_growl(:visitor, visiting_user_id, "Your Profile was Viewed", true)
      elsif visitor.updated_at < 3.hours.ago
        notify_growl(:visitor, visiting_user_id, "Your Profile got viewed again", false)
        visitor.touch
      end
    end
  end

  def notify_growl(event, visiting_user_id, title, badge_update)
    visited_user = User.find(visiting_user_id)
    to_user_id = visited_user.id

    data = {}
    data[:img]   = current_user.avatar
    data[:title] = title
    data[:profile_id] = current_user.profile.id
    data[:event] = event
    data[:datetime] = DateTime.now.to_i

    channel_name = "/messages/#{to_user_id}"
    PrivatePub.publish_to channel_name, :data => data
    if badge_update
      badge_increment(visited_user, event.to_s)
    end
  end
  def badge_increment(user, event)
    if event == "interest"
      user.badge.update(interest: user.badge.interest + 1)
    elsif event == "visitor"
      user.badge.update(visitor: user.badge.visitor + 1)
    elsif event == "accepted"
      # user.badge.update(accepted: user.badge.accepted + 1)
    elsif event == "rejected"
      # user.badge.update(rejected: user.badge.rejected + 1)
    end
  end
  def badge_reset(user, event)
    if event == "interest"
      user.badge.update(interest: 0)
    elsif event == "visitor"
      user.badge.update(visitor: 0)
    elsif event == "accepted"
      # user.badge.update(accepted: 0)
    elsif event == "rejected"
      # user.badge.update(rejected: 0)
    end
  end
  def has_sex
    if current_user.sex == "Unknown" || current_user.dob == "01/01/1900" || current_user.avatar.content_type.nil?
      redirect_to confirmbasic_others_path
    end
  end
end