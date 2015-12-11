FactoryGirl.define do
  factory :like do
    user

    factory :post_like do
      association :likeable, :factory => :post
    end

    factory :comment_like do
      association :likeable, :factory => :comment
    end

    factory :photo_like do
      association :likeable, :factory => :photo
    end
  end
end