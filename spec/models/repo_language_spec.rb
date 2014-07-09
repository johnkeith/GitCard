require_relative '../rails_helper'

describe RepoLanguage do
  it { should belong_to :repo }
  it { should belong_to :language }
end

describe Repo, '.new_repo_language' do
end
