FactoryGirl.define do
  factory :notice do
    user nil
    message "MyString"
  end
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password "!23456Yuiopasdf"
    token    nil
    failed   nil
    last_attempt nil
  end

  factory :bio do
    association :profile
    slogan "I'm a Prude"
    about "Catch Me if you can"
  end

  factory :friend_request do
    association :user
    association :request, factory: :user
  end

  factory :friends_user do
    association :user
    association :friend, factory: :user
  end

  factory :gallery do
    association :user
    title "gallery title"
    description "graph"
  end

  factory :image do
    association :gallery
    url "http://img.com"
    description "a picture"
  end

  factory :like do
    association :user
    association :post
  end

  factory :post do
    association :user
    post_type "Post"
    body "Post Body"
    likes_count 0
    comments_count 0
  end

  factory :profile do
    association :user
    first_name "Hermione"
    last_name "Granger"
    birthday Date.today
    gender "Female"
    college "Hogwarts"
    hometown "Heathgate, London"
    current_home "Ron's Pad"
    phone "555-555-5555"
    association :profile_img, factory: :image
    cover nil
    edited false
  end
end
