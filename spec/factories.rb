
FactoryGirl.define do
  factory :friendship_status do
    description "MyString"
  end

  factory :photo do
    user nil
  end

  factory :user, aliases: [:friender, :friendee, :friend] do
    sequence(:email){ |n| "foo#{n}@bar.com"}
    password 'foobarfoobar'
    password_confirmation 'foobarfoobar'
    friendships_count 0
    trait :with_profile do
      association :profile
    end
    trait :with_pending_friend_request do
      after(:create) do |user|
        user.friendees << create(:friendee, :with_profile)
      end
    end
    trait :with_rejected_friend_request do
      after(:create) do |user|
        user.friendees << create(:friendee, :with_profile)
        Friendship.last.update(rejected: true)
      end
    end
    trait :with_accepted_friend_request do
      after(:create) do |user|
        friend = create(:friend, :with_profile)
        create(:friendship, rejected: false, friendee_id: friend.id, friender_id: user.id)
        create(:friendship, :not_rejected,  friendee_id: user.id, friender_id: friend.id)
      end
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
    association :friend_initiator, factory: :friender
    association :friend_recipient, factory: :friendee
    rejected nil
    trait :not_rejected do
      rejected false
    end

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
