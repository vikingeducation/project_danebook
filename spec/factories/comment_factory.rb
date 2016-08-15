FactoryGirl.define do
  factory :comment do
    body "This is a post"
    user
    post
  end
end