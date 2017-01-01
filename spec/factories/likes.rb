FactoryGirl.define do
  factory :like do
    user

    factory :comment_like do
      association :likeable, factory: :comment
    end
    factory :post_like do
      association :likeable, factory: :post
    end

  end
end
