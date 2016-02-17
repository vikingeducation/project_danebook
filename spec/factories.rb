FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@email.com"}
    password "password"
    first_name "First"
    last_name "Last"
  end



end