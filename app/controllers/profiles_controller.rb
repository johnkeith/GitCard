class ProfilesController < ApplicationController
  def edit
    ok_client = OctokitConnector.create(current_user)
    Repo.refresh_user_repos(ok_client, current_user)
    @repos = current_user.repos.order(:name)
  end
  
  def show
    # need authentication filter, better way of redirect users 
    # away from profiles that don't exist
    @user = User.find_by(username: params[:username])
    
    if !@user.profile_created
      current_user.update_attribute(:profile_created, true)
      redirect_to edit_profile_path(current_user.username)
    end

    languages = LanguageCalculator.new(@user)
    @languages_bytes = languages.in_bytes
    @languages_percents = languages.in_percents(@languages_bytes)
    @repos = @user.repos.where(profile_visibility: true)
  end
end
