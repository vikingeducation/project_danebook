FactoryGirl.define do

  factory :comment do
    sequence(:body) { |n| "Foo comment #{n}." }
    author
    post
  end

end