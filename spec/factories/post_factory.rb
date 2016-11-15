FactoryGirl.define do
  factory :post do
    sequence(:body) {|n| FactoryHelper.text(n)}
    user
  end
end