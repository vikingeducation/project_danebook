
FactoryGirl.define do
  factory :photo do
    user nil
  end
  factory :user, aliases: [:friender, :friendee] do
    sequence(:email){ |n| "foo#{n}@bar.com"}
    password 'foobarfoobar'
    password_confirmation 'foobarfoobar'
    friendships_count 0
    trait :with_profile do
      association :profile
    end
  end
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sex 'female'
    birthdate { Faker::Date.birthday(13,99)}
    college { Faker::University.name }
    hometown { Faker::Address.city }
    current_city { Faker::Address.city }
    telephone { Faker::PhoneNumber.phone_number }
    quote { Faker::Hacker.say_something_smart }
    about { Faker::Hipster.sentence(3) }
    user
    trait :male do
      sex 'male'
    end
  end
  factory :friendship do
    friender
    friendee
  end
  factory :post do
    body  { Faker::Hacker.say_something_smart }
    user

    trait :with_likes do
      transient do
        likes_count 3
      end
      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
      end
    end
  end
  factory :like do
    post
    user

  end
  factory :comment do
    body Faker::Hacker.say_something_smart
    user
    post
  end
  factory :comment_like do
    comment
    user
  end

end
