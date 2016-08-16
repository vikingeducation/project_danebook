FactoryGirl.define do

  factory :user do
    sequence :email do |n|
      "foob#{n}@barbaz.com"
    end
    password "foobar1234"
    activated true
  end

  factory :profile do
    user
    words "#{Faker::Lorem.paragraph(2)}"
    about "#{Faker::Lorem.paragraph(3)}"
    first_name "#{Faker::Name.first_name}"
    last_name "#{Faker::Name.last_name}"
    college "#{Faker::University.name}"
    
    # after(:build) do |profile|
    #   profile.hometown = build(:hometown, addressable: profile)
    #   profile.residence = build(:residence, addressable: profile)
    # end

    # after(:create) do |profile|
    #   profile.hometown = create(:hometown, addressable: profile)
    #   profile.residence = create(:residence, addressable: profile)
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
    # After building a hometown, set its address to a new instance of the :address factory. :address's addressable association shall point to the said hometown.
    after(:build) do |hometown|
      hometown.address = build(:address, addressable: hometown)
    end

    # Same, but for creating.
    after(:create) do |hometown|
      hometown.address = create(:address, addressable: hometown)
    end
  end

  factory :residence do
    after(:build) do |residence|
      residence.address = build(:address, addressable: residence)
    end

    after(:create) do |residence|
      residence.address = create(:address, addressable: residence)
    end
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

