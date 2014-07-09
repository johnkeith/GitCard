require_relative "../rails_helper"

describe Repo do
  it { should belong_to :user }
  it { should have_many :repo_languages }
  it { should have_many :languages }

  describe '.refresh_user_repos' do
    it "description" do
      user = double('User', id: 20)
      octokit_client = double('OctokitClient')
      allow(octokit_client).to receive(:repositories) { [1, 2, 3] }

      expect(Repo).to receive(:refresh_repo).with 1
      expect(Repo).to receive(:refresh_repo).with 2
      expect(Repo).to receive(:refresh_repo).with 3

      Repo.refresh_user_repos(octokit_client, user)
    end
  end
end
