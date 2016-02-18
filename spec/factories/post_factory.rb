FactoryGirl.define do

  factory :post do
    sequence(:body) { |n| "This is post#{n}!"}
    user
  end

end
