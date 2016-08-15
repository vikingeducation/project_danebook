FactoryGirl.define do

  factory :user do
    sequence :email do |n|
      "foobar#{n}@barbaz.com"
    end
    password "abcdefghi"
  end

  factory :profile do
    user
    words "#{Faker::Lorem.paragraph(2)}"
    about "#{Faker::Lorem.paragraph(3)}"
    first_name "#{Faker::Name.first_name}"
    last_name "#{Faker::Name.last_name}"
    college "#{Faker::University.name}"
  end

  factory :post do
    user

    title "#{Faker::Lorem.words(4)}"
    body "#{Faker::Lorem.paragraph(3)}"

    trait :with_likes do

      transient do
        likes_count 5
      end

      after(:build) do |post,evaluator|
        create_list(:like, evaluator.likes_count, likeable: post)
      end
    end

  end

  factory :comment do
    user
    
    body "#{Faker::Lorem.paragraph(3)}"

    trait :with_likes do

      transient do
        likes_count 5
      end

      after(:build) do |comment,evaluator|
        create_list(:like, evaluator.likes_count, likeable: comment)
      end
    end

  end

  factory :like do
    user
  end

end

