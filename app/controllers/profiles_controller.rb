class ProfilesController < ApplicationController
  def edit
    ok_client = OctokitConnector.create(current_user)
    if !current_user.profile_created
      Repo.new_user_repos(ok_client, current_user)
    else
      Repo.refresh_user_repos(ok_client, current_user)
    end
    @user = current_user
    @repos = @user.repos.order(:name)
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
    # API endpoint for calendar data stopped working around 8-18-14.
    # Leaving VelocityCalculator class until issue can be addressed
    
    # @velocity = VelocityCalculator.new(@user)
  end

  def refresh
    ok_client = OctokitConnector.create(current_user)
    respond_to do |format|
      if Repo.refresh_user_repos(ok_client, current_user)
        format.json { render nothing: true }
      end
    end    
  end
end
