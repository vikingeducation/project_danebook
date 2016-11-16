FactoryGirl.define do
  factory :like do
    user

    trait :on_post do
      association :likeable, factory: :post
    end

    trait :on_comment do
      association :likeable, factory: :comment
    end

  end
end