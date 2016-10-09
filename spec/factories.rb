FactoryGirl.define do
  factory :feature do
    
  end
  factory :user_park do
    
  end
  factory :park do
    
  end
  factory :photo do
    
  end
  factory :friending do
    
  end

  factory :user do

    sequence(:email) do |n|
      "abcde#{n}@abcd.com"
    end

    password "asdfasdf"

    trait :without_attributes do
      email nil
      password nil
    end

  end

  factory :post do

    body "Randomly generated post content."

    trait :without_attributes do
      body nil
    end

    user

  end

  factory :profile do

    trait :with_attributes do
      first_name "foo"
      last_name "bar"
      gender "male"
      birthdate Date.parse("09/02/1977")
      hometown "New York, NY"
      current_residence "Boston, MA"
      telephone "9383922933"
      words_to_live_by "No words."
      about_me "No about."
    end

    user

  end

  factory :like do

    user
    post

  end

  factory :comment do

    user
    post
    body "This is a comment."

  end

end