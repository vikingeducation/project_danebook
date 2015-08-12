FactoryGirl.define do

  factory :user, aliases: [:author, :liker, :friend_initiator, :friend_recipient] do
  #  first_name  "Foo"
  #  sequence(:last_name) { |n| "Bar#{n}" }
  #  email       "#{first_name}@#{last_name}.com"
  end

  #factory :post do
  #  title "Foo Title"
  #  author
  #end

end