require_relative '../rails_helper'

Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 20 # seconds

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
    repos = FactoryGirl.create_list(:repo, 3, user: user, profile_visibility: true)
    binding.pry
    VCR.use_cassette('github_calendar_data_request') do
      visit "/#{user.username}"
    end

    expect(page).to have_content repos[0].name
    expect(page).to have_content repos[1].name

    expect(page).to have_xpath "//a[@href=\"#{repos[0].html_url}\"]"
    expect(page).to have_xpath "//a[@href=\"#{repos[1].html_url}\"]"
  end

  # scenario "user sees languages statistics on profile" do
  #   user = FactoryGirl.create(:user, profile_created: true)
  #   repos = FactoryGirl.create_list(:repo, 3, user: user)
  #   langs = FactoryGirl.create_list(:language, 3)
  #   lang_calc = LanguageCalculator.new(user)
  #   repos.each do |repo|
  #     langs.each do |lang|
  #       FactoryGirl.create(:repo_language, {repo: repo, language: lang})
  #     end
  #   end

  #   VCR.use_cassette('github_calendar_data_request') do
  #     visit "/#{user.username}"
  #   end
    
  #   lang_calc.in_bytes.each do |lang, amount|
  #     expect(page).to have_content amount
  #   end

  #   lang_calc.in_percents(lang_calc.in_bytes).each do |lang, amount|
  #     expect(page).to have_content amount
  #   end
  # end

  scenario "user sees velocity statistics on profile" do
    user = FactoryGirl.create(:user, profile_created: true)
  end

  scenario "user's github profile picture appears on profile" do
    user = FactoryGirl.create(:user, profile_created: true)

    VCR.use_cassette('github_calendar_data_request') do
      visit "/#{user.username}"
    end

    expect(page).to have_xpath "//img[@src=\"#{user.avatar_url}\"]"
  end
end
