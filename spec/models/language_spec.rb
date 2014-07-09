require_relative '../rails_helper'

describe Language do
 it { should have_many :repo_languages }
 it { should validate_presence_of(:name) }
 it { should validate_uniqueness_of(:name) }
end
