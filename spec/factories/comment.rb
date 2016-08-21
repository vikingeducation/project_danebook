FactoryGirl.define do
  factory :comment do
    description "A description of a commment"

    user
    post
  end
end
