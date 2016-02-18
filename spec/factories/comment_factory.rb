FactoryGirl.define do

  factory :comment, aliases: [:post_comment] do
    sequence(:body) { |n| "This is post comment#{n}!"}
    user
    association :commentable, factory: :post
    after(:create) { |comment| comment.commentable.comments << comment }
  end

end
