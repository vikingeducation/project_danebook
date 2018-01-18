FactoryBot.define do

  factory :friending, aliases: [:initiator, :recipient] do
    association :friend_initiator, factory: :user
    association :friend_recipient, factory: :user
  end


end #FactoryBot
