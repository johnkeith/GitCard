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
    safe_params = params.require(:user).permit(:description, :twitter_url,
      :facebook_url, :github_url, :linkedin_url, :personal_site_url)
    %w(twitter_url facebook_url github_url linkedin_url
      personal_site_url).each do |site|
        unless safe_params[site] == ""
          safe_params[site] = validate_url(safe_params[site])
        end
      end
    safe_params
  end

  def validate_url(url)
    url = url.downcase
    if url.include?("http://www.") || url.include?("https://www.")
      url
    elsif url.include?("www.")
      "http://" + url
    elsif !url.include?("http://www.") || !url.include?("https://www.")
      "http://www." + url
    end
  end
end
