FactoryGirl.define do

  factory :liking do
    user
    #f.association :liking, factory: :likeable
  end
end