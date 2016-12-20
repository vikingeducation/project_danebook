FactoryGirl.define do
  factory :post do
    association :user
    body { "Body of post" }
    created_at { Time.now }
  end
end
