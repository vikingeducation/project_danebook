FactoryGirl.define do
  factory :comment, aliases: [:likeable] do
    body "Comment Body HERE"
    commentable
    author
    trait :liked do
      after(:build) do |comment|
        FactoryGirl.create(:comment_like, likeable: comment)
      end
    end
  end

end
