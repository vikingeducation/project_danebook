FactoryGirl.define do
  factory :photo do
    
  end
#call back to create profile
  factory :user do
    email 'asdf@asdf.com'
    password '123456'
  end

  factory :profile do
    first_name 'Bob'
    last_name 'Bob'
    birthday Date.today
    gender 'Male'
    association :user, factory: :user
  end

  factory :post do
    body 'posting body'
    like_count 0
    created_at Date.yesterday
    association :user, factory: :user
  end

  factory :comment do
    body 'commenting body'
    like_count 0
    created_at Date.yesterday
    association :user, factory: :user
  end

  factory :post_like do
    likeable_type 'Post'
    created_at Date.yesterday
    association :post, factory: :post
    association :user, factory: :user
  end


end
