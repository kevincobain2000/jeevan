class OthersController < ApplicationController
  skip_before_filter :authenticate_user!, :except => ["confirmbasic"]
  def modify_gender
    if params[:sex] == "Male" || params[:sex] == "Female"
      current_user.update("sex" => params[:sex])
    end
    if params[:dob]
      current_user.update("dob" => params[:dob])
    end
    redirect_to root_path
  end
end
