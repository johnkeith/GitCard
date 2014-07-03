class ProfilesController < ApplicationController
  def edit
    ok_client = OctokitConnector.create(current_user)
    
    if current_user.profile_created
      Repo.refresh_user_repos(ok_client, current_user)
    else
      Repo.add_new_user_repos(ok_client, current_user)
    end
    
    @repos = current_user.repos
  end

  def show
    if current_user.profile_created

    else
      redirect_to edit_profile_path(current_user.username)
    end
  end
end
