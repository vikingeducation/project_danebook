FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
      first_name  "Foo"
      last_name   "Bar"
      password "password"
      password_confirmation "password"
  end
end