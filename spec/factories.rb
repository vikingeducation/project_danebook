FactoryGirl.define do
  factory :image do
    
  end

  factory :user, :aliases => [:author] do
    sequence(:username){ |n| "foo_bar#{n}"}
    email { "#{username}@bar.com" }
    password "foobar12"

    #sequence(:email){ |n| "#{n}@aol.com"}

  end


  factory :profile do
    sequence(:first_name){ |n| "foo#{n}"}
    sequence(:last_name){ |n| "bar#{n}"}
    gender    "m"
    birthdate "10-10-1990"
    college   "Some College"
    domicile  "Domicile"
    hometown  "Hometown"
    phone     "4088964196"

    user
  end

  factory :post do
    sequence(:body){ |n| "Post Body #{n}"}

    user

  end


  factory :like do

    #likeable_id 1
    #likeable_type "Post"
    association :likeable, factory: :post
    association :liked_by, factory: :user

  end
end

  