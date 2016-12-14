FactoryGirl.define do

  # TODO refactor About to include name, make it clear its talking about the user who's timeline you're on. 
  factory :comment do
    body "this is some comment"
    user
    commentable
  end

end 