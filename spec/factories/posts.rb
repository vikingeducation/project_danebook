FactoryGirl.define do

  factory :post, aliases: [:commentable] do
    body "Post Body HERE"
    author
  end
end
