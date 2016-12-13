FactoryGirl.define do
  factory :friending do
    
  end

  factory :user do
    sequence(:email){ |n| "#{n}@example.com" }
    password "asdfasdf"
  end

  factory :profile do
    first_name
    last_name
    
    association :user, factory: :user
  end


end
