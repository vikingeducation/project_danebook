FactoryGirl.define do
  factory :comment do
    description "A description of a commment"

    user

    factory :post_comment do
      association :postable, factory: :post
    end

    factory :photo_comment do
      association :postable, factory: :photo
    end

    factory :comment_comment do
      association :postable, factory: :comment
    end

  end
end
