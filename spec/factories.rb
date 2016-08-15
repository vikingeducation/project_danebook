FactoryGirl.define do

  factory :user do
    email "foobar@barbaz.com"
    password "abcdefghi"
  end

  factory :profile do
    user
    words "#{Faker::Lorem.paragraph(2)}"
    about "#{Faker::Lorem.paragraph(3)}"
    first_name "#{Faker::Name.first_name}"
    last_name "#{Faker::Name.last_name}"
    college "#{Faker::University.name}"
  end

end

