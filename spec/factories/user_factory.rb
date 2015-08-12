FactoryGirl.define do

  factory :user, aliases: [:author, :liker, :friend_initiator, :friend_recipient] do
    sequence(:email)  { |n| "foo#{n}@bar.com" }
    password          "foobar"
  end

end