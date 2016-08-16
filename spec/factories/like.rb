FactoryGirl.define do
  factory :like do

    trait :post_like do
      association :likes, factory: :post
    end
    trait :comment_like do
      association :likes, factory: :comment
    end
    post
    comment
  end
end
