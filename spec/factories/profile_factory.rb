FactoryGirl.define do

  factory :profile do
    college 'UCLA'
    hometown 'LA'
    current_location 'LA'
    telephone '6666666666'
    words "i'm very cool"
    about_me "super cool"

    after(:build) do |profile|
      profile.user ||= build(:user, :profile => profile)
    end


  end

end