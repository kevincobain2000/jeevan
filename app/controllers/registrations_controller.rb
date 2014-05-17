class RegistrationsController < Devise::RegistrationsController
  protected

  # def after_inactive_sign_up_path_for(resource)
  #   '/others/confirmemail'
  # end
  def after_sign_up_path_for(resource)
    '/others/confirmemail'
  end
end