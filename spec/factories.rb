FactoryGirl.define do
  factory :user do
    first_name {"foo"}
    last_name {"bar"}
    sequence(:email){|n|"foo#{n}@bar.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end