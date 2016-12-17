FactoryGirl.define do
  factory :photo do
    
  end
  factory :friending do
    
  end
  factory :user do
    first_name "Bob"
    last_name "Dobbs"
    email "bob@subgenius.org"
    password "password"
  end

  factory :profile do
    birthday Time.now
    gender "Male"
    college "Somewhere Over the Rainbow"
    hometown "Jonesboro"
    city "Fillydelphia"
    telephone "555-555-5555"
    words_to_live_by "I ate some food."
    about_me "I was young once."
  end

end