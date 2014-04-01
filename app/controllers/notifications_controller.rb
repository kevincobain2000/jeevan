class NotificationsController < ApplicationController
  FLAG_VISITOR            = 0
  FLAG_EXPRESSED_INTEREST = 0
  FLAG_ACCEPTED_INTEREST  = 0
  FLAG_REJECTED_INTEREST  = 0
  def index

  end
  def seen
    notification = Notification.find(notification_params[:notification_id])
    if notification.created_at < 1.month.ago
      notification.delete()
    else
      notification.update(seen: 1)
    end
    render json: { :status => 200 }
  end

  private
  def notification_params
    params.permit(:notification_id)
  end
end
