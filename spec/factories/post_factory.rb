FactoryGirl.define do
  factory :post do
    body { "Test post" }
    user
  end
end
