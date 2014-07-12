class HomeController < ApplicationController
  def index
    if current_user
      redirect_to profile_path(current_user.username)
    end
  end
end
