FactoryGirl.define do

  factory :comment, aliases: [:liked] do
    sequence(:body) { |n| "Foo comment #{n}." }
    author
  end

end