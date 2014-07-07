class ProfilesController < ApplicationController
  def edit
    ok_client = OctokitConnector.create(current_user)

    Repo.refresh_user_repos(ok_client, current_user)
    
    @repos = current_user.repos
  end

  # def update_visibility
  #   @repo = Repo.find(params[:id])
  #   @repo.toggle(:profile_visibility)
    
  #   respond_to do |format|
  #     if @repo.save
  #       format.html { redirect_to edit_profile_path(current_user.username) }
  #       format.json { render json: @repo, status: :successful }
  #     else
  #       format.html { render action: "edit" }
  #       format.json {}
  #     end
  #   end
  # end
  
  def show
    if current_user.profile_created

    else
      redirect_to edit_profile_path(current_user.username)
    end
  end
end
