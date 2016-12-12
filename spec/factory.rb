FactoryGirl.define do

  factory :user, aliases: [:friend] do
    sequence(:first_name) do |n|
      "foo#{n}"
    end

    sequence(:last_name) do |n|
      "bar#{n}"
    end
 
    email {"#{first_name}@bar.com"}
    password "password"
  end

end
