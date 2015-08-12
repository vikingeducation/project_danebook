FactoryGirl.define do

  factory :profile do
    first_name            "Foo"
    sequence(:last_name)  { |n| "Bar#{n}" }
    gender                "Male"
    birthdate             20.years.ago
    college               "Foo University"
    hometown              "Fooville"
    currently_lives       "Foo City"
    telephone             "123-456-7890"
    words_to_live_by      "Foo quote."
    description           "Foo biography."
    user
  end

end