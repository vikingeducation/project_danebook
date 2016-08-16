FactoryGirl.define do
  factory :friending do

    association :friend_initiator, factory: :user
    association :friend_recipient, factory: :user
  end
end
