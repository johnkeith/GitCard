require_relative "../rails_helper"

describe Repo do
  it { should belong_to :user }
  it { should have_many :repo_languages }
  it { should have_many :languages }

  describe '.refresh_user_repos' do
    it "retrieves a new repo not in database" do
      repo = FactoryGirl.create(:repo)
      repo_langs = { :Ruby=>38898, :JavaScript=>983, :CoffeeScript=>104,
        :CSS=>4196 }
      
      user = double('User', id: 20)
      octokit_client = double('OctokitClient')
      
      allow(octokit_client).to receive(:repositories) {[repo]}
      allow(RepoLanguage).to receive(:repo_languages).and_return repo_langs
      allow(RepoLanguage).to receive(:create_repo_languages)

      expect(Repo).to receive(:create_repo).with repo, user

      Repo.refresh_user_repos(octokit_client, user)
    end
  end
end

# require_relative "../rails_helper"

# describe Repo do
#   it { should belong_to :user }
#   it { should have_many :repo_languages }
#   it { should have_many :languages }

#   describe '.refresh_user_repos' do
#     it "description" do
#       user = double('User', id: 20)
#       octokit_client = double('OctokitClient')
#       allow(octokit_client).to receive(:repositories) { [1, 2, 3] }

#       expect(Repo).to receive(:refresh_repo).with 1
#       expect(Repo).to receive(:refresh_repo).with 2
#       expect(Repo).to receive(:refresh_repo).with 3

#       Repo.refresh_user_repos(octokit_client, user)
#     end
#   end
# end

# require_relative "../rails_helper"

# describe Repo do
#   it { should belong_to :user }
#   it { should have_many :repo_languages }
#   it { should have_many :languages }

#   describe '.refresh_user_repos' do
#     it "retreives a new repo not in database" do
#       repo = FactoryGirl.create(:repo)
#       # repo_mock = { name: "A", user_id: 1, full_name: "bob/a", html_url: "www.example.com" }
#       repo_langs = { :Ruby=>38898, :JavaScript=>983, :CoffeeScript=>104, :CSS=>4196 }
      
#       user = double('User', id: 20)
#       octokit_client = double('OctokitClient')
#       repo_language = double('RepoLanguage')
      
#       allow(octokit_client).to receive(:repositories) {[repo]}

#       allow(repo_language).to receive(:repo_languages).and_return repo_langs

#       expect(Repo).to receive(:create_repo).with repo, user

#       Repo.refresh_user_repos(octokit_client, user)
#     end
#   end
# end
