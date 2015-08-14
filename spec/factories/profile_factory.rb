FactoryGirl.define do

  factory :base_profile, :class => :profile do
    first_name            "Foo"
    sequence(:last_name)  { |n| "Bar#{n}" }
    gender                "Male"
    birthdate             20.years.ago

    factory :full_profile do
      college               "Foo University"
      hometown              "Fooville"
      currently_lives       "Foo City"
      telephone             "123-456-7890"
      words_to_live_by      "Foo quote."
      description           "Foo biography."
    end

  end

end