FactoryGirl.define do

  factory :user do
    email "foobar@barbaz.com"
    password "abcdefghi"

    association :profile, first_name: 'Foobar', last_name: 'Barbaz'
  end

  factory :profile do
  end

end