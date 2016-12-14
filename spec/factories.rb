FactoryGirl.define do
#call back to create profile
  factory :user do
    email "asdf@asdf.com"
    # sequence(:email){ |n| "#{n}@example.com" }
    password "123456"
  end

  factory :profile do
    first_name "Bob"
    last_name "Bob"
    birthday Date.today
    gender "Male"

    association :user, factory: :user
  end


end
