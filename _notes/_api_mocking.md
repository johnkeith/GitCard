# How I mocked an API interaction using VCR, Webmock, and Github

I'm working on an app involving the Github API, which will be my final project here at Launch Academy, and I overcame a major hurdle today by successfully mocking an API interaction in my testing. The resources I found on this thoroughly misifying subject were less than illuminating, but I finally pieced together something workable to mock up my interaction with Github that uses the Octokit gem. 

Here's the approach to API mocking that worked for me using rspec, capybara, vcr, webmock, and Octokit/Omniauth-Github.

First, open your gemfile and add the vcr, webmock, and rack_session_access gems to your :test group. 

``` ruby
group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'rack_session_access'
end
```
Run bundle, then open your spec/rails_helper. Add these configurations to setup vcr. 

``` ruby
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
``` 

You will also need to setup wemock in your spec/spec_helper. 

``` ruby 
require 'webmock/rspec'
require "rack_session_access/capybara"

WebMock.disable_net_connect!(allow_localhost: true)
```

(Note, the above to snippets need to sit outside the Rspec.configure blocks in each of their respective files).

Next, you will need to create your feature file. Go ahead and create the tests you will need for the scenario, paying attention to where mocking of an API call will need to occur. 

You will also need to get an access token for the api you are tyring to make a call to. For me, that process involved firing up Rails and doing a real sign in, then opening up the Rails console so that I could copy the access token assigned to my real Github account by the request. 

I have a FactoryGirl for creating a user and used that factory, adding my own access_token to make the request valid.

```ruby
# spec/factories/user.rb
FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "123456#{n}" }
    provider "github"
    username "ghuser"
    avatar_url "http://www.example.com/ghuser.jpg"
    email "ghuser@github.com"
    access_token "123456788999000"
  end
end
```
``` ruby
# spec/features/create_profile_spec.rb
scenario "CREATE MOCK API REQUEST USING VCR" do 
  user = FactoryGirl.create(:user, access_token: "12345")
end
```

Inside your scenario, call the use_cassette method on the VCR class in order to start recording the API request. In my case, this API call is triggered upon a user navigating to the edit path for their profile page. 

```ruby
VCR.use_cassette('user_requests_repos') do
  visit edit_profile_path(user.username)
end
```

Next came adding the profiles controller, model and the migrations to create the repos table, along with associations on the user and repo model.

The key thing was setting up all the models and associations that needed to be created.

```ruby 
scenario "CREATE MOCK API REQUEST USING VCR" do 
  user = FactoryGirl.create(:user, access_token: "123456")

  page.set_rack_session(:user_id => user.id)

  VCR.use_cassette('github_repos_request') do
    visit edit_profile_path(user.username)
  end
end
