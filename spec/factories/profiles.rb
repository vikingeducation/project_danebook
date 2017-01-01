FactoryGirl.define do

  factory :profile do
    sequence(:first_name) { |n| "Tester#{n}" }
    last_name "Mc#{:first_name}"
    birthday 30.years.ago
    user
  end
end
