FactoryGirl.define do

  sequence(:email) do |i|
    "testy#{i}@testface.com"
  end

  factory :profile do
    user
    birthday { 2.days.ago }
  end

  factory :user do
    first_name { "Testy" }
    last_name { "McTestFace" }
    email
    password { "testtesttest" }
  end

end
