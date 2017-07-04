FactoryGirl.define do
  factory :photo do
    user
    asset_file_name { 'image.png' }
    asset_content_type { 'image/png' }
    asset_file_size { File.new("#{Rails.root}/spec/support/fixtures/image.png").size }
  end

  factory :status do
    trait :accepted do
      message "Accepted"
    end
    trait :pending do
      message "Pending"
    end
  end

  factory :friend_request do
    association :user_one_id, factory: :user
    association :user_two_id, factory: :user
    association :status_id, factory: :user
  end

  factory :user do
    sequence(:email) { |i| "foo#{i}@bar.com".downcase }
    password "foobar123"
    password_confirmation "foobar123"
  end

  factory :profile do
    user
    sequence(:first_name) { |i| "foo#{i}" }
    sequence(:last_name) { |i| "bar#{i}" }
    birthday{ Time.now }
    gender { ["male", "female"].sample }
    words "Dolore deserunt duis excepteur officia velit ea irure occaecat excepteur deserunt aliqua ut mollit anim veniam culpa."
    about "Dolore deserunt duis excepteur officia velit ea irure occaecat excepteur deserunt aliqua ut mollit anim veniam culpa."
    association :profile_photo_id, factory: :photo
    association :cover_photo_id, factory: :photo
  end

  factory :post_ do
    user
    sequence(:body) { |i| "Hello #{i}" }
  end

end
