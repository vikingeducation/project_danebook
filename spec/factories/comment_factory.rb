FactoryGirl.define do
  factory :comment do
    body "This is a comment"
    user
    post
  end
end