class SessionsController < Devise::SessionsController
  before_filter :set_thumbs

  def set_thumbs
    if !user_signed_in?
      @thumbs = []
      users_with_avatars = User.where("avatar_updated_at IS NOT NULL").order('avatar_updated_at DESC').limit(20)
      users_with_avatars.each do |user|
        @thumbs << user.avatar
      end
    end
  end
end