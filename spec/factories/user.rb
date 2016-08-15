FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Chuck#{n}" }
    last_name "Norris"
    email { "#{first_name}@exaxmple.com" }
    birth_date (Date.today - 10000)
    password "password"
    password_confirmation "password"

    # before_create :generate_token
    # after_create :create_profile
  end
end
