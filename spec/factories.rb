FactoryGirl.define do

  factory :user do
    first_name  "foo"
    last_name   "Bar"
    email       "foo@bar.com"
    password "password"
    password_confirmation "password"
  end

  factory :profile do
    birthday          1970-10-01
    college           "hard knocks"
    hometown          "ontario"
    current_town      "rochester"
    telephone         "555-555-5555"
    words_to_live_by  "breathe deep"
    about_me          "i code"
    user_id           1
  end

end