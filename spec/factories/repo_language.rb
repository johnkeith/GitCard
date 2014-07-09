FactoryGirl.define do
  factory :repo_language do
    amount_in_bytes "#{Random.rand(10000)}"
    repo
    language
  end
end
