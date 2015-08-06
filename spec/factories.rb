# spec/factories.rb
FactoryGirl.define do
  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password "foobar"
  end

end