class SessionsController < ApplicationController
  def create
    auth = env['omniauth.auth']

    user = User.find_or_create_from_omniauth(auth)
    
    set_current_user(user)

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end
