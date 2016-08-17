FactoryGirl.define do 
  factory :profile do 
    college     "Harvard"
    hometwon    "Spokane"
    currently_lives "New York"
    telephone   "555-555-5555"
    life_words  "Words " + "words " * 80 + " words."
    about_me  "Words " + "words " * 80 + " words."
    birth_date   Date.today
    association :user
  end
end