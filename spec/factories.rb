FactoryGirl.define do

  factory :friendship do
    friendee { create(:user) }
    friender { create(:user) }
  end

  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :post do
    user
    body {Faker::RickAndMorty.quote}
  end

  factory :comment do
    user
    post
    body {Faker::Simpsons.quote}
  end

  factory :profile do
    user
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    birthday {Faker::Date.birthday(18, 65)}
    college {Faker::University.name}
    hometown {Faker::Address.city}
    current_town {Faker::Address.city}
    words_to_live_by {Faker::RickAndMorty.quote}
    about_me {Faker::Simpsons.quote}
    gender {["Male", "Female"].sample}
  end


end
