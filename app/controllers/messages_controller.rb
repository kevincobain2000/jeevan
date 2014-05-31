class MessagesController < ApplicationController
  helper_method :get_latest_message_snippet
  before_filter :not_talking_with_same_sex,:only => [:show]
  def index
    conversations = Message.where("user_id = ? OR to_user_id = ?", current_user.id, current_user.id).order("created_at DESC")
    spoken_with = conversations.pluck(:user_id,:to_user_id).flatten.uniq - [current_user.id]
    @spoken_with = spoken_with.paginate(:page => params[:page], :per_page => 10);
    current_user.badge.update(message: 0)
  end

  #/messages/:user_id
  def show
    talking_with_user_id = params[:id]
    @messages = Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", current_user.id, talking_with_user_id, talking_with_user_id, current_user.id).order("created_at DESC").limit(30).reverse
  end

  def send_message
    message = message_params[:message]
    if message.gsub(/\s+/, "").length > 0
      user = User.find(params[:to_user_id])
      # to_user_id = Profile.find(params[:to_user_id]).user_id
      to_user_id = user.id
      Message.create(:user_id => current_user.id, :to_user_id => to_user_id, :message => message)
      response = { :status => 200 }
      notify_growl(:message, params[:to_user_id], "Message Received", message, true)
      user.badge.update(message: user.badge.message + 1)
    else message.length == 0
      response =  { :error => "Sorry, your message is corrupted", :status => 422 }
    end
    render json: response
  end

  def get_latest_message_snippet(user_id_one, user_id_two)
    return Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", user_id_one, user_id_two, user_id_two, user_id_one).order("created_at DESC").first
  end

  def notify_growl(event, visiting_user_id, title, message, badge_update)
    visited_user = User.find(visiting_user_id)
    to_user_id = visited_user.id

    data = {}
    data[:img]   = current_user.avatar
    data[:title] = title
    data[:profile_id] = current_user.profile.id
    data[:event] = event
    data[:datetime] = DateTime.now.to_i
    data[:message] = message

    channel_name = "/messages/#{to_user_id}"
    PrivatePub.publish_to channel_name, :data => data
  end

  protected
  def message_params
    params.permit([:to_user_id, :message])
  end
  def not_talking_with_same_sex
    user = User.find(params[:id])

    if (params[:id] == current_user.id) || (current_user.sex == user.sex)
      redirect_to root_path
    end
  end
end
