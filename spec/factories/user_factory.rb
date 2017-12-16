FactoryGirl.define do

  sequence(:email) do |n|
    "foo#{n}@bar.com"         
  end

  sequence(:firstname) do |n|
    "foo#{n}"         
  end

  sequence(:lastname) do |n|
    "test#{n}"          
  end

  sequence(:birthday) do |n|
    DateTime.new(1960+n,1+n,5+n)
  end

  factory :user do |n|
    email       
    password_digest  { BCrypt::Password.create("foobar") }
  end

  factory :profile do
    user
    firstname
    lastname
    birthday
    gender { ["Male", "Female"].sample } 
    telephone { "0123 456 7890"}   
    college { "Test college" }
    hometown { "Test Hometown" }
    currently_lives { "Nowhere"}
    words_to_live_by { "Seize the day" }
    about_me { "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." }
  end
end
