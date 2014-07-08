class Language < ActiveRecord::Base
  has_many :repo_languages
  validates :name,
    presence: true, 
    uniqueness: true
end
