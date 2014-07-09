class RepoLanguage < ActiveRecord::Base
  belongs_to :repo
  belongs_to :language

  def self.repo_languages(octokit_client, repo)
    octokit_client.languages(repo.full_name).to_attrs
  end

  def self.refresh_repo_languages(octokit_client, repo)
    repo_languages(octokit_client, repo).each do |lang_name, code_amount|
      language = Language.find_or_create_by(name: lang_name)
      repo_lang = RepoLanguage.find_by(repo_id: repo.id, language_id: language.id)
      if repo_lang.nil?
        RepoLanguage.create(repo_id: repo.id, language_id: language.id,
          amount_in_bytes: code_amount)
      else
        repo_lang_to_update = RepoLanguage.find_by(repo_id: repo.id, language_id: language.id)
        repo_lang_to_update.update_columns(amount_in_bytes: code_amount)
      end
    end
  end

  def self.create_repo_languages(octokit_client, repo)
    repo_languages(octokit_client, repo).each do |lang_name, code_amount|
      language = Language.find_or_create_by(name: lang_name)
      RepoLanguage.create(repo_id: repo.id, language_id: lang.id,
        amount_in_bytes: code_amount)
    end
  end

  #  def self.new_repo_language(ok_client, repo)
  #   repo_langs = ok_client.languages(repo.full_name).to_attrs
  #   repo_langs.each do |lang_name, code_amount|
  #     if Language.where(name: lang_name).empty?
  #       lang = Language.create(name: lang_name)
  #     else 
  #       lang = Language.find_by(name: lang_name)
  #     end
  #     RepoLanguage.create(repo_id: repo.id, language_id: lang.id,
  #       amount_in_bytes: code_amount)
  #   end
  # end
end
