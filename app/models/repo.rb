class Repo < ActiveRecord::Base
  belongs_to :user
  has_many :repo_languages
  has_many :languages, through: :repo_languages

  def self.refresh_user_repos(ok_client, user)
    ok_client.repositories.each do |repo|
      if Repo.where(user_id: user.id, name: repo[:name]).empty?
        new_repo = Repo.create(user_id: user.id, name: repo[:name],
          full_name: repo[:full_name], html_url: repo[:html_url],
          profile_visibility: true )
        RepoLanguage.new_repo_language(ok_client, new_repo)
      end
    end
  end

  def self.add_new_user_repos(ok_client, user)
    ok_client.repositories.each do |repo|
      new_repo = Repo.create(user_id: user.id, name: repo[:name],
        full_name: repo[:full_name], html_url: repo[:html_url],
        profile_visibility: true )
      RepoLanguage.new_repo_language(ok_client, new_repo)
    end
  end

end
