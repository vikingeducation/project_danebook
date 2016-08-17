FactoryGirl.define do
  factory :post do
    body    "Body text" * 87
    association :author, :factory => :user
  end
end