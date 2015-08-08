FactoryGirl.define do

  factory :user do
    first_name  "Foo"
    last_name   "Bar"
    email "testest@test.com"
    # sequence(:email) do |n| "foo#{n}@gmail.com" end
    gender      "male"
    birthday    Time.now
    password "password"

  end

  factory :profile do
    user_id 1
  end

  factory :post do
    user_id 1
    body    "ifsifhsjkfhfwehioquwehfweufhweouifqweioufhuih"
  end

  factory :comment do
    user_id 1
    body    "ifsifhsjkfhfwehioquwehfweufhweouifqweioufhuih"
  end
end