FactoryGirl.define do
  factory :profile do
    first_name "Harry"
    last_name "Potter"
    gender "Male"
    birthday "1993-11-09"
    user
  end
end