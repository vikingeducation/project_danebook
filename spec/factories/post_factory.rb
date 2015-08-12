FactoryGirl.define do

  factory :post do
    sequence(:body) { |n| "Foo post #{n}." }
    author
  end

end