FactoryGirl.define do
  factory :profile_photo do
    profile nil
    photo nil
  end
  factory :photo do
    data ""
    filename "TheFile"
    mime_type "jpg"
  end

  factory :timeline do

    # building/creating a timeline
    after(:build) do |timeline|
      timeline.user = build(:user)
    end

    after(:create) do |timeline|
      timeline.user = create(:user)
    end

  end

  factory :user do
    sequence :email do |n|
      "foob#{n}@barbaz.com"
    end
    password "foobar1234"
    activated true

    # building/creating a profile
    after(:build) do |user|
      user.profile = build(:profile)
    end

    after(:create) do |user|
      user.profile = create(:profile)
    end

  end

  factory :profile do
    words "a few words"
    about "about myself"
    first_name "#{Faker::Name.first_name}"
    last_name "#{Faker::Name.last_name}"
    college "A College"

    after(:build) do |profile|
      profile.hometown = build(:hometown)
      profile.residence = build(:residence)
    end

    after(:create) do |profile|
      profile.hometown = create(:hometown)
      profile.residence = create(:residence)
    end

  end

  factory :post do
    user

    title "#{Faker::Lorem.words(4)}"
    body "#{Faker::Lorem.paragraph(3)}"

    trait :with_likes do

      transient do
        likes_count 5
      end

      after(:build) do |post,evaluator|
        create_list(:like, evaluator.likes_count, likeable: post)
      end
    end

  end

  factory :comment do
    user

    body "#{Faker::Lorem.paragraph(3)}"

    trait :with_likes do

      transient do
        likes_count 5
      end

      after(:build) do |comment,evaluator|
        create_list(:like, evaluator.likes_count, likeable: comment)
      end
    end

  end

  factory :like do
    user
  end

  # Polymorphic: addressable
  factory :hometown do
    after(:create) do |hometown|
      hometown.address = create(:address)
    end
  end

  factory :residence do
    after(:create) do |hometown|
      hometown.address = create(:address)
    end
  end

  factory :address do
    country "#{Faker::Address.country}"
    state "#{Faker::Address.state}"
    city "#{Faker::Address.city}"
  end

  factory :birthday do
    trait :with_valid_date do
      date_object { 30.years.ago }
    end

    trait :with_invalid_date do
      date_object { 5.years.ago }
    end
  end

end
