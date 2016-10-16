# spec/factories.rb
FactoryGirl.define do
  factory :friendship do
    initiator 1
    recipient 1
  end
  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
  factory :user, aliases: [:author] do
    sequence(:first_name){|n| "Foo#{n}" }
    sequence(:last_name){|n| "Bar#{n}" }
    email       { "#{first_name}@bar.com" }
    password    "foobar123"
    birthday    "#{DateTime.now}"
    gender_cd   1
  end

  factory :profile do
    college "College1"
    hometown "543 San Fran, CA"
    address  "123 West field, Kentucky"
    phone    "123-456-708"
    status   "win ein win"
    about    "hahahahaha"
    user
  end

  factory :post do
    text "Hola Amigo"
    likes_count 0
    user
  end

  factory :comment do
    text "New Comment"
    likes_count 0
    author
    post
  end
end