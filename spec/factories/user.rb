FactoryGirl.define do
  factory :user do
    first_name "Adahn"
    last_name "Adahn"
    sequence(:email) {|n| "adahn#{n}@planescape.tor"}
    password "adahnadahn"


    after(:build) do |user|
      user.profile ||= FactoryGirl.build(:profile, :user => user)
    end

  end
end