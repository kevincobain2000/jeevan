module ProfilesHelper
  def get_visitors_user_ids(limit = 100)
    Visitor.where(viewed_id: current_user.id).order("created_at DESC").limit(limit).pluck(:user_id)
  end
  def get_user_visited_user_ids(limit = 100)
    Visitor.where(user_id: current_user.id).order("created_at DESC").limit(limit).pluck(:viewed_id)
  end
  def get_shortlist_user_ids(limit = 100)
    Shortlist.where(user_id: current_user.id).order("created_at DESC").limit(limit).pluck(:to_user_id)
  end
end
