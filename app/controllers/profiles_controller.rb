class ProfilesController < ApplicationController
  def edit
    ok_client = OctokitConnector.create(current_user)

    Repo.refresh_user_repos(ok_client, current_user)
    
    @repos = current_user.repos
  end
  
  def show
    if !current_user || current_user.profile_created
      @user = User.find_by(username: params[:username])
    else
      current_user.update_attribute(:profile_created, true)
      redirect_to edit_profile_path(current_user.username)
    end
  end
end
