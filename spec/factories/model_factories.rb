FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Chuck#{n}" }
    last_name "Norris"
    birth_date (Date.today - 10000)
    email "#{name}@exaxmple.com"
    password "password"
    password_confirmation "password"
  end
end
