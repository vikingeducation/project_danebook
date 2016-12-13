FactoryGirl.define do
  factory :comment do
    body "this is some comment"
    user
    commentable
  end

end 