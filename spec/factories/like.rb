FactoryGirl.define do
  factory :like do
    user

    factory :post_like do
      association :likes, factory: :post
    end

    factory :photo_like do
      association :likes, factory: :photo
    end

    factory :comment_like do
      association :likes, factory: :comment
    end
  end
end
