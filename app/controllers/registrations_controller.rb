class RegistrationsController < Devise::RegistrationsController
   # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource

      # respond_with resource, location: session_path(resource)
      # response = { :status => 200 }
      # response =  { :error => "Sorry, your message is corrupted", :status => 422 }
      # render :json => { :success => false, :data => resource.errors.full_messages } 
      # return render json: response
      # redirect_to (back, resource)
      session[:devise_error] = resource.errors.full_messages
      redirect_to :back

      # respond_with resource
    end
  end
  def failure
    response =  { :error => "Sorry, your message is corrupted", :status => 422 }
    return render json: response
  end
  protected

  # def after_inactive_sign_up_path_for(resource)
  #   '/others/confirmemail'
  # end
  # def after_sign_up_path_for(resource)
  #   '/others/confirmemail'
  # end

end