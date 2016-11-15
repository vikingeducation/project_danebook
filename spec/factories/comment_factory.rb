FactoryGirl.define do
  factory :comment do
    sequence(:body) {|n| FactoryHelper.text(n)}
    user

    factory :post_comment do
      association :commentable, :factory => :post
    end

    factory :photo_comment do
      association :commentable, :factory => :photo
    end
  end
end

