require_relative '../rails_helper'

feature "signed up user customizes profile", %q(
  As a user, I want to choose which repos of mine to display,
  so that my profile shows off my best work on Github.
) do
  # Acceptance Criteria:
  # I can sign up for an account and import my Github repos
  # I can choose which repos I want to display on my page
  # I will be redirected to my page after choosing my repos
  
  scenario "user has not choosen what repos to display" do
    user = FactoryGirl.create(:user)

    page.set_rack_session(user_id: user.id)
    
    VCR.use_cassette('github_repos_request') do 
      visit edit_profile_path(user.username)
    end

    expect(page).to have_content("Ruby2048") 
    expect(page).to have_content("CarMan")
  end

  scenario "user chooses repos to display" do
    user = FactoryGirl.create(:user)

    page.set_rack_session(user_id: user.id)
    
    VCR.use_cassette('github_repos_request') do 
      visit edit_profile_path(user.username)
    end

    expect(page).to have_css('input[data-repo-name="HubMe"]')
    expect(page).to have_css('input[data-repo-name="wallofbeer"]')
  end

end
