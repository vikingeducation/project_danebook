FactoryGirl.define do  

  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password "testtest"
  end 
  
  factory :post do
    sequence(:words) { |n| "post #{n}" }
    user
  end
  
  factory :comment do
    words "comment"
    user
  end
  
end