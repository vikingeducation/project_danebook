FactoryGirl.define do

  sequence(:email) do |i|
    "testy#{i}@testface.com"
  end

  factory :profile do
    user
    birthday { 2.days.ago }
  end

  sequence(:first_name) do |i|
    "Testy#{i}"
  end

  factory :user do
    first_name
    last_name { "McTestFace" }
    email
    password { "testtesttest" }
  end

end
