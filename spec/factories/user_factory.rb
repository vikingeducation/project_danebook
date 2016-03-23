FactoryGirl.define do

  factory :user do
    sequence(:first_name) { |n| "foo#{n}"}
    sequence(:last_name) { |n| "bar#{n}"}
    email { "#{first_name}@#{last_name}.com" }
    password "qwerqwer"
  end

end
