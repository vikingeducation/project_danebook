FactoryGirl.define do

  factory :user do
    first_name "Foo"
    last_name "Bar"
    email "foo@bar.com"
    password "12345678"
    gender 1
    dob "2015-08-05"
  end

end