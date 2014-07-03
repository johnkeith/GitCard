require_relative '../rails_helper'

feature "user authorizes with github and creates account", %q(
  As a user, I want to be able to sign in with my Github account, 
  so that I can customize my profile on the site.
) do
  # Acceptance Criteria:
  # I can sign in using my Github credentials
  scenario "user is not signed in" do
    visit '/'

    expect(page).to_not have_content 'Sign out'
  end

  scenario "user creates an account and signs in" do
    user = FactoryGirl.create(:user, profile_created: true)
  
    set_omniauth(user)

    visit '/'

    click_on 'Sign in with Github'

    expect(page).to_not have_content 'Sign in with Github'
    expect(page).to have_content 'Sign out'
  end

end
