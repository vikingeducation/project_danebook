FactoryGirl.define do

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
  end

  factory :post_ do
    user
    sequence(:body) { |i| "Hello #{i}" }
  end

end
