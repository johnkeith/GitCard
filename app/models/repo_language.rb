class RepoLanguage < ActiveRecord::Base
  belongs_to :repo
  belongs_to :language

  def self.new_repo_language(ok_client, repo)
    repo_langs = ok_client.languages(repo.full_name).to_attrs

    repo_langs.each do |lang_name, code_amount|
      if Language.where(name: lang_name).empty?
        lang = Language.create(name: lang_name)
      else 
        lang = Language.find_by(name: lang_name)
      end
      RepoLanguage.create(repo_id: repo.id, language_id: lang.id, amount_in_bytes: code_amount)
    end
  end
end
