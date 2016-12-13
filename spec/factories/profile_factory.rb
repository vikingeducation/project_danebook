FactoryGirl.define do
  factory :profile do 
    birthday {40.years.ago}
    gender "Male"
    college "Haunted"
    hometown "Away"
    residence "No"
    telephone "6101232345"
    summary "lorem"
    about_me "ipsum"
  end

end
