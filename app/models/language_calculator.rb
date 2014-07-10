class LanguageCalculator
  def initialize(user)
    @user = user
  end

  def in_bytes
    langs_hash = {}

    @user.languages.each do |lang|
      langs_hash[lang[:name]] = 0
    end

    @user.repo_languages.includes(:language).each do |repo_language|
      lang = repo_language.language.name
      # lang = Language.find_by(id: repo_language.language_id).name
      langs_hash[lang] += repo_language.amount_in_bytes
    end

    langs_hash
  end

  def in_percents(langs_hash)
    langs_percents = {}
    total = langs_hash.values.sum

    langs_hash.each do |lang, amount|
      langs_percents[lang] = ((amount / total.to_f) * 100).ceil
    end

    langs_percents
  end
end
