FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "123456#{n}" }
    provider "github"
    username "ghuser"
    full_name "Johnny Github"
    avatar_url "http://www.example.com/ghuser.jpg"
    email "ghuser@github.com"
    access_token "123456788999000"
  end
end
