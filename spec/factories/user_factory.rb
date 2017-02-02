FactoryGirl.define do

  factory :user do
    sequence(:first_name) { |n| "aubrey#{n}"}
    sequence(:last_name) { |n| "graham#{n}"}
    sequence(:email) { |n| "aubrey#{n}@graham.com" }
    birth_date 24
    birth_month 10
    birth_year 1986
    password 'legend'
  end

end