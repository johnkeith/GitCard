class ReposController < ApplicationController
  def update
    @repo = Repo.find(params[:id])

    respond_to do |format|
      binding.pry
      if @repo.update(repo_params)
      # if @repo.toggle!(:profile_visibility)
      # if @repo.update_attribute(:profile_visibility, [true|false])
        format.html { redirect_to edit_profile_path(current_user.username) }
        format.json { render json: @repo, status: :successful }
      else
        format.html { render action: "edit", notice: "Change unsuccessful. Please try again." }
        format.json {}
      end
    end
  end

  private

  def repo_params
    params.require(:repo).permit(:profile_visibility)
  end
end
