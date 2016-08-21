
FactoryGirl.define do
  factory :profile do
    college "College Name"
    hometown "City_In, CA"
    currently_lives "City_In, CA"
    telephone "555-555-5555"
    words_to_live_by Faker::ChuckNorris.fact
    about_me Faker::ChuckNorris.fact

    user
  end
end
