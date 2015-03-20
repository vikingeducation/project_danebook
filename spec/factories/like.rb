FactoryGirl.define do
  factory :like do
    association :user



    factory :post_like do
      association :likable, factory: :post
    end

    factory :comment_like do
      association :likable, factory: :comment
    end

    factory :photo_like do
      association :likable, factory: :photo
    end

  end
end