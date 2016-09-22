FactoryGirl.define do
  factory :post do
      content "BLAH!!"
      from 1
      association :user 
  end
end