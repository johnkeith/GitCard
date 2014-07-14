class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update(user_params)
        format.html {}
        format.json { render json: @user, status: 200 }
      else
        format.html {}
        format.json {}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:description, :twitter_url,
      :facebook_url, :github_url, :linkedin_url, :personal_site_url)
  end
end
