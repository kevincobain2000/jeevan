class OthersController < ApplicationController
  skip_before_filter :authenticate_user!
  def confirmemail
  end
  def confirmgender
    
  end
  def modify_gender
    if params[:sex] == "Male" || params[:sex] == "Female"
      current_user.update("sex" => params[:sex])
    end
    redirect_to root_path
  end
end
