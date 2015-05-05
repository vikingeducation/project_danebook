FactoryGirl.define do
  factory :profile do

    month 11
    day 11
    year 2011
    gender "Rather Not Say"


    after(:build) do |profile|
      profile.user ||= FactoryGirl.build(:user, :profile => profile)
    end

  end
end