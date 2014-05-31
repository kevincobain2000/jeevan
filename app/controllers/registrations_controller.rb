class RegistrationsController < Devise::RegistrationsController
  before_filter :set_thumbs

  def set_thumbs
    @thumbs = []
    users_with_avatars = User.where("avatar_updated_at IS NOT NULL").order('avatar_updated_at DESC').limit(9)
    users_with_avatars.each do |user|
      @thumbs << user.avatar
    end
  end
  protected

  # def after_inactive_sign_up_path_for(resource)
  #   '/others/confirmemail'
  # end
  # def after_sign_up_path_for(resource)
  #   '/others/confirmemail'
  # end
end