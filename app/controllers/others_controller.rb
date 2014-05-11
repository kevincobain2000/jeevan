class OthersController < ApplicationController
  skip_before_filter :authenticate_user!
  def confirmemail
  end
end
