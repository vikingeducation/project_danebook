FactoryGirl.define do
  factory :post do
    association :user
    body { "Body of post" }
  end
end
