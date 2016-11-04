FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :profile do
    first_name 'Foo'
    last_name 'Bar'
    birthday DateTime.now - 1
    user
  end

  factory :post do
    post_text 'imapostimapost'
    user
  end

  factory :comment do
    comment_text 'imacomment'
    user
    post
  end

  factory :like do
    user
    likeable_id 1
    likeable_type 'Post'
  end

  factory :friending do
    association(:friending_initiator, factory: :user)
    association(:friending_recipient, factory: :user)
  end
end
