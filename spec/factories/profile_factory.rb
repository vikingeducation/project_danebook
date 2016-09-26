FactoryGirl.define do

  factory :profile do
    user
    sequence(:first_name) { |n| "fname_#{n}"}
    sequence(:last_name) { |n| "lname#{n}"}
    month "Jan"
    day 26
    year 1995
    gender "male"
  end
end