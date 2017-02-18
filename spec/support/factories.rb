FactoryGirl.define do

  factory :user do
    first_name "Bob"
    last_name "Dobbs"
    email "bob@subgenius.org"
    password "password"
    trait :no_first_name do
      first_name nil
    end
    trait :no_last_name do
      last_name nil
    end
    trait :no_email do
      email nil
    end
    trait :diff_user do
      first_name "Bill"
      email "bill@subgenius.org"
    end
    trait :squidward do
      first_name "Squidward"
      last_name "Tentacles"
    end
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
    trait :empty do
      birthday nil
      gender nil
      college nil
      hometown nil
      city nil
      telephone nil
      words_to_live_by nil
      about_me nil
    end
  end

  factory :post do
    body "THIS IS ME POST"
  end

  factory :comment do
    body "THIS BE ME COMMENT"
  end

  factory :like do
  end

end