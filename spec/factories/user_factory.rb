FactoryGirl.define do

  factory :user do
    first_name  "Foo"
    last_name   "Bar"
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password    "foobazbar"
    gender      "male"
    
    trait :with_auth_token do 
      auth_token SecureRandom.urlsafe_base64
    end    
  end

end