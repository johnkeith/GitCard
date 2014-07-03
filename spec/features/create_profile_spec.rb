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

    expect(page).to have_content("Thanks for signing up for GitCard! Please click
      on the checkboxes next to the repos you want to display on your profile page.")
    expect(page).to have_content("HubMe") 
    expect(page).to have_content("CarMan")
  end

  scenario "user chooses repos to display" do
    user = FactoryGirl.create(:user)

    page.set_rack_session(user_id: user.id)
    
    VCR.use_cassette('github_repos_request') do 
      visit edit_profile_path(user.username)
    end

    check "HubMe"
    check "CarMan"

    expect(page).to have_content("Remember, you can always add these repos to your page later by clicking the settings wheel in the top right.")

    click_button "View Profile"
  end

end
