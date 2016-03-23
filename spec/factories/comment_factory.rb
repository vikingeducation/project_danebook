FactoryGirl.define do

  factory :post_comment, class: "Comment" do
    sequence(:body) { |n| "This is post comment#{n}!"}
    user
    association :commentable, factory: :post
    after(:create) { |comment| comment.commentable.comments << comment }
  end

end
