class BlogsController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    flash[:notice] = "this"
    @blogs = Blog.all.paginate(:page => params[:page], :per_page => 1)
  end 
  def show

  end
end
