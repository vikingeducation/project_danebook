FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:first_name) {|n| "Foo#{n}"}
    last_name "bar"
    email{"#{first_name}@#{last_name}.com"}
    password "password"
  end

  factory :friender, class: User do
    first_name "friender"
    last_name "initiator"
    email{"#{first_name}@#{last_name}.com"}
    password "password"
  end

  factory :friended, class: User do
    first_name "friended"
    last_name "receiver"
    email{"#{first_name}@#{last_name}.com"}
    password "password"
  end


  factory :post do
    body "Hello World!"
    author
  end

  factory :multi_posts, class: Post do
    sequence(:body){|n| "Hello World!#{n}"}
    author
  end


  factory :profile do
    birthday 2016-04-20
    hometown "los angeles"
    current_location "los angeles"
    school "UCLA"
    motto "YOLO"
    about "Swag dab"
    telephone "123-333-4445"
    gender "male"
    user
  end

  factory :comment do
    body "What a great comment!"
    author
  end

  factory :like do
    author
  end

  factory :post_like, class: Like do
    association :likeable, factory: :post
    author
  end

  factory :friending do
    association :friend_initiator, factory: :friender
    association :friend_receiver, factory: :friended
  end

end