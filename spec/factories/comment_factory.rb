FactoryGirl.define do
  factory :comment do
    sequence(:body) {|n| FactoryHelper.text(n)}
    user

    factory :post_comment do
      association :commentable, :factory => :post
    end
  end
end