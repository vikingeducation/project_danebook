require 'rails_helper'

FactoryGirl.define do

  factory :user do
    sequence(:first_name){ |n| "Foo#{n}"}
    email    { "#{first_name}@bar.com"}
    last_name "bar"
    password "password"
    password_confirmation "password"
    birthdate   {Date.parse('20-10-2000')}
  end

  factory :profile do
    college     "Some College"
    hometown    "Obscure Hometown"
    location    "Knowhere"
    phone       "111-111-1111"
    motto       "Do or Do Not"
    about       "lorem stuff here"
    gender      "male"

    user
  end

  factory :post do

  end

  factory :comment do

  end

  factory :like do

  end

  # factory :friend do
  # end

  # factory :friending do
  # end

end