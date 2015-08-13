FactoryGirl.define do

  factory :profile do
    college_name "foo state"
    hometown "fooville"
    current_home "fooville"
    telephone "555555555"
    words_to_live_by "foo or not to foo"
    about_me "I foo!"

    user
  end
end