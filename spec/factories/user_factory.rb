FactoryGirl.define do

  factory :user, aliases: [:poster, :author, :liker, :friend_initiator, :friend_recipient] do
    sequence(:email)  { |n| "foo#{n}@bar.com" }
    password          "foobar"
    association :profile, factory: :full_profile
  end

end