class NotificationsController < ApplicationController
  def seen
    # todo
    # Interest.where("to_user_id = ? OR user_id = ? AND seen <> ?", current_user.id, current_user.id, 2).update_all(:seen => 2)
    render json: { :status => 200 }
  end
end
