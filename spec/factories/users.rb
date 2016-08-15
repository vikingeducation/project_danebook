FactoryGirl.define do

  factory :user, aliases: [:author] do

    sequence(:email) { |n| "email#{n}@email.com" }
    password  "password"

  end
end
