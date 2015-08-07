FactoryGirl.define do

  factory :user do
    sequence(:first_name) { |n| "FOo#{n}"}
    last_name "Bar"
    email { "#{first_name}@bar.com" }
    password "12345678"
    gender 1
    dob "2015-08-05"
  end

end