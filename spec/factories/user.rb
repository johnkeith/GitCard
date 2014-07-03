FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "123456#{n}" }
    provider 'github'
    username 'ghuser'
    avatar_url 'http://www.example.com/ghuser.jpg'
    email 'ghuser@github.com'
  end
end
