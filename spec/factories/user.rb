FactoryGirl.define do
  factory :user do
    first_name "Adahn"
    last_name "Adahn"
    sequence(:email) {|n| "adahn#{n}@planescape.tor"}
    password "adahnadahn"
  end
end