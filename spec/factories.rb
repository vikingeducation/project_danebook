FactoryGirl.define do

  factory :user do
    sequence :email do |n|
      "foob#{n}@barbaz.com"
    end
    password "foobar1234"
    activated true
    
    after(:build) do |user|
      user.profile = build(:profile)
    end

    after(:create) do |user|
      user.profile = create(:profile)
    end
  end

  factory :profile do
    words "#{Faker::Lorem.paragraph(2)}"
    about "#{Faker::Lorem.paragraph(3)}"
    first_name "#{Faker::Name.first_name}"
    last_name "#{Faker::Name.last_name}"
    college "#{Faker::University.name}"
    
    # after(:build) do |profile|
    #   profile.hometown = build(:hometown)
    #   profile.residence = build(:residence)
    # end

    # after(:create) do |profile|
    #   profile.hometown = create(:hometown)
    #   profile.residence = create(:residence)
    # end

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
    profile
    association :address
  end

  factory :residence do
    profile
    association :address
  end

  factory :address do
  end

  factory :country do
    # Each element of the address shall point to the :address factory.
    address
    sequence :name do |n|
      "#{Faker::Address.country}#{n}"
    end
  end

  factory :state do
    address
    sequence :name do |n| 
      "#{Faker::Address.state}#{n}"
    end
  end

  factory :city do
    address
    sequence :name do |n|
      "#{Faker::Address.city}#{n}"
    end
  end

end

