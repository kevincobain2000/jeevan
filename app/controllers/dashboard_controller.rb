class DashboardController < ApplicationController
  def index
      @interests = {in: Interest.where(to_user_id: current_user.id), responses: Interest.where(user_id: current_user.id)}
      @visitors = {out: current_user.visitors, in:Visitor.where(viewed_id: current_user.id)}
  end
end
