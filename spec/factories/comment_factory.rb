FactoryGirl.define do

  factory :comment do
    sequence(:body) { |n| "Foo comment #{n}." }
    author

    trait :on_post do
      association :commentable, :factory => :post
    end

    trait :on_photo do
      association :commentable, :factory => :photo
    end

  end

end