FactoryGirl.define do

  factory :post, aliases: [:liked] do
    sequence(:body) { |n| "Foo post #{n}." }
    author
  end

end