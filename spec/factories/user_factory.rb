FactoryGirl.define do

  factory :user do
    first_name  "Foo"
    last_name   "Bar"
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password    "foobazbar"
    gender      "male"
    
  end

end