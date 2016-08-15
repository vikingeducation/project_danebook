FactoryGirl.define do

  factory :user do

    sequence(:username) { |n| "tuser_#{n}"}
    email { "#{username}@email.com"}
    password "abc123."
    password_confirmation "abc123."

  end
end