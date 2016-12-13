FactoryGirl.define do

  sequence(:email) do |i|
    "testy#{i}@testface.com"
  end

  factory :user do
    first_name { "Testy" }
    last_name { "McTestFace" }
    email
    password { "testtesttest" }
    # association :friends, factory: :friending, optional: true
  end
end
