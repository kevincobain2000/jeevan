module MessagesHelper
  def get_latest_message_snippet(user_id_one, user_id_two)
    return Message.where("(user_id = ? AND to_user_id = ?) OR (user_id = ? AND to_user_id = ?)", user_id_one, user_id_two, user_id_two, user_id_one).order("created_at DESC").first
  end
end
