include ActionView::Helpers::DateHelper
include ActionView::Helpers::NumberHelper
include ActionView::Helpers::TextHelper
include ActiveSupport::Inflector

module ApplicationHelper
  def make_user(user, from_id = false)
    if from_id == true
      user = User.find(user);
    end
    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first

    profile = user.profile

    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "Profile Id: #{user.profile.id}"

    user_ret = {
      id:         user.id,
      dob:        dob,
      age:        age,
      name:       truncate(name).capitalize,
      updated_at: time_ago_in_words(user.updated_at),
      created_at: time_ago_in_words(user.created_at),
      sex:        user.sex.capitalize,
      visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
      profile:    profile,
      contact:    user.contact,
      about:      user.about,
      religion:   user.religion,
      devotion:   user.devotion,
      kundali:    user.kundali,
      family:     user.family, #----------
      occupation:     user.occupation, #----------
      hobby:      user.hobby, #----------
      education:  user.education, #----------
      lifestyle:  user.lifestyle, #----------
      desire:     user.desire, #----------
      image:      user.images.all,
      images_count:      user.images_count.to_i,
      avatar:     user.avatar,
      in_response:  in_response,
      out_response: out_response,
      shortlist:    Shortlist.where(user_id: current_user.id, to_user_id: user.id).first,
    }
    return user_ret
  end
  def make_user_card(user, from_id = false)
    if from_id == true
      user = User.find(user);
    end
    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first

    profile = user.profile

    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "Profile Id: #{user.profile.id}"

    user_ret = {
      id:         user.id,
      dob:        dob,
      age:        age,
      name:       truncate(name).capitalize,
      updated_at: time_ago_in_words(user.updated_at),
      created_at: time_ago_in_words(user.created_at),
      # sex:        user.sex.capitalize,
      # visitors:   number_with_delimiter(Visitor.where(viewed_id: user.id).count),
      profile:    profile,
      # contact:    user.contact,
      about:      {me: user.about.me},
      religion:   user.religion,
      devotion:   user.devotion,
      # kundali:    user.kundali,
      image:      user.images.all,
      images_count:      user.images_count.to_i,
      avatar:     user.avatar,
      provider:     user.provider,
      in_response:  in_response,
      out_response: out_response,
      # shortlist:    Shortlist.where(user_id: current_user.id, to_user_id: user.id).first,
    }
    return user_ret
  end

  def make_user_tiny(id)
    user = User.find(id)
    in_response  = Interest.where(to_user_id: current_user.id, user_id: user.id).first
    out_response = Interest.where(user_id: current_user.id, to_user_id: user.id).first
    itts = user.sex == "Male" ? "He" : "She"
    name = show_name_to_accepted(in_response, out_response) ? user[:name] : "Profile id: #{user.profile.id}"

    dob = user.dob.gsub("/","-")
    age = calculate_age(dob)

    user_ret = {
      avatar: user.avatar,
      age:        age,
      updated_at: time_ago_in_words(user.updated_at),
      profile: user.profile,
      name: name,
      id: user.id,
      in_response:  in_response,
      out_response: out_response,
    }
    return user_ret
  end
  def get_user_from_uid(user_id)
    User.find(user_id)
  end
  def calculate_age(birthday)
    the_age = Date.today.year - birthday.to_date.year
    age = the_age > 100 ? "xx" : the_age

  end
  def show_name_to_accepted(in_response, out_response)
    if (in_response) || (out_response && out_response.response == 1)
      return true
    end
  end
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
end