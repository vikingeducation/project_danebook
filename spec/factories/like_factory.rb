FactoryGirl.define do

  factory :post_like, class: "Like" do
    user
    association :likeable, factory: :post
    after(:create) { |like| like.likeable.likes << like }
  end

  factory :comment_like, class: "Like" do
    user
    association :likeable, factory: :post_comment
    after(:create) { |like| like.likeable.likes << like }
  end

  
end
