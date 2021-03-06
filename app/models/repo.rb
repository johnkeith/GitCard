class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :repo_languages
  has_many :languages, through: :repo_languages

  def self.refresh_user_repos(octokit_client, user)
    octokit_client.repositories.each do |repo|
      if Repo.find_by(user_id: user.id, name: repo[:name]).nil?
        new_repo = create_repo(repo, user)
        RepoLanguage.create_repo_languages(octokit_client, new_repo)
      else
        updated_repo = refresh_repo(repo, user)
        RepoLanguage.refresh_repo_languages(octokit_client, updated_repo)
      end
    end
  end

  def self.refresh_repo(repo, user)
    repo_to_update = Repo.find_by(user_id: user.id, name: repo[:name])
    repo_to_update.update_columns(
      user_id: user.id, name: repo[:name], full_name: repo[:full_name],
      html_url: repo[:html_url], description: repo[:description]
    )
    repo_to_update
  end

  def self.new_user_repos(octokit_client, user)
    octokit_client.repositories.each do |repo|
      new_repo = create_repo(repo, user)
      RepoLanguage.create_repo_languages(octokit_client, new_repo)
    end
  end

  def self.create_repo(repo, user)
    Repo.create(
      user_id: user.id, name: repo[:name], full_name: repo[:full_name],
      html_url: repo[:html_url], description: repo[:description]
    )
  end
end
