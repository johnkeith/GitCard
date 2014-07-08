require_relative '../rails_helper'

feature "", %q(
  As a user, I want to be able to view my profile, 
  so that I can find out statistics about my Github usage
) do 
  # Acceptance Criteria:
  # I can view a profile page at gitcard/myusername
  # I can see statistics about my language usage
  # I can see statistics about the velocity of my commits

  scenario "user views repos on profile" do
    user = FactoryGirl.create(:user, profile_created: true)
    repos = FactoryGirl.create_list(:repo, 3, user: user)

    visit "/#{user.username}"

    expect(page).to have_content repos[0].name
    expect(page).to have_content repos[1].name

    expect(page).to have_xpath "//a[@href=\"#{repos[0].html_url}\"]"
    expect(page).to have_xpath "//a[@href=\"#{repos[1].html_url}\"]"
  end

  scenario "user sees languages statistics on profile" do
    user = FactoryGirl.create(:user, profile_created: true)
    repos = FactoryGirl.create_list(:repo, 3, user: user)
    langs = FactoryGirl.create_list(:language, 3)
    repos.each do |repo|
      langs.each do |lang|
        FactoryGirl.create(:repo_language, repo: repo, language: lang)
      end
    end
    binding.pry
  end

  scenario "user sees velocity statistics on profile" do
  end

  scenario "user's github profile picture appears on profile" do
  end
end
