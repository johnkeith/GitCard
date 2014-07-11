class User < ActiveRecord::Base
  has_many :repos
  has_many :repo_languages, through: :repos
  has_many :languages, through: :repo_languages

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_by(provider: provider, uid: uid) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      username: auth.info.nickname,
      full_name: auth.info.name,
      avatar_url: auth.info.image,
      access_token: auth.credentials.token, 
      gh_account_created: auth.extra.raw_info.created_at
    )
  end
end
