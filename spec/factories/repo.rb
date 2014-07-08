FactoryGirl.define do
  factory :repo do
    sequence(:full_name) {|n| "#{user.username}/repo#{n}" }
    sequence(:name) {|n| "repo#{n}"}
    sequence(:html_url) {|n| "http://github.com/#{user.username}/repo#{n}"}
    user
  end
end

