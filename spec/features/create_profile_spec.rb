require_relative '../rails_helper'

feature "signed up user customizes profile", %q(
  As a user, I want to choose which repos of mine to display,
  so that my profile shows off my best work on Github.
) do
  # Acceptance Criteria:
  # I can sign up for an account and import my Github repos
  # I can choose which repos I want to display on my page
  # I will be redirected to my page after choosing my repos

  scenario "CREATE MOCK API REQUEST USING VCR" do 
    user = FactoryGirl.create(:user, access_token: "312d4d07769cd79c54fed381da67ac42c39495ab")
    
    VCR.use_cassette('user_requests_repos') do
      visit edit_profile_path(user.username)
    end

  end

  # scenario "user has not choosen what repos to display" do
  #   user = FactoryGirl.create(:user)

  #   page.set_rack_session(user_id: user.id)
    
  #   VCR.use_cassette('ok_client.repos') do 
  #     visit edit_profile_path(user.username)
  #   end

  #   expect(page).to have_content("Thanks for signing up for GitCard! Please click
  #     on the checkboxes next to the repos you want to display on your profile page.")
  #   expect(page).to have_content("HubMe") 
  #   expect(page).to have_content("CarMan")
  # end

  # scenario "user chooses repos to display" do
  #   user = FactoryGirl.create(:user)

  #   page.set_rack_session(user_id: user.id)
    
  #   VCR.use_cassette('ok_client.repos') do 
  #     visit edit_profile_path(user.username)
  #   end

  #   check "HubMe"
  #   check "CarMan"

  #   expect(page).to have_content("Remember, you can always add these repos to your page later by clicking the settings wheel in the top right.")

  #   click_button "View Profile"
  # end

end
