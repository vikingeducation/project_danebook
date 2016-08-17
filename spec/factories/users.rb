FactoryGirl.define do

  factory :user, aliases: [:author] do

    sequence(:email) { |n| "email#{n}@email.com" }
    password  "password"
    password_confirmation "password"
  end
end
