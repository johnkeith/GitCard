class ReposController < ApplicationController
  def update
    @repo = Repo.find(params[:id])

    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to edit_profile_path(current_user.username) }
        format.json { render json: @repo, status: 200 }
      else
        format.html { render action: "edit" }
        format.json {}
      end
    end
  end

  def toggle_visibility
    @repo = Repo.find(params[:id])

    respond_to do |format|
      if @repo.toggle!(:profile_visibility)
        format.json { render json: @repo, status: 200 }
      else
        format.json {}
      end
    end
  end

  private

  def repo_params
    params.require(:repo).permit(:profile_visibility)
  end
end
