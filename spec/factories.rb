FactoryGirl.define do
  factory :friending do
    
  end
  factory :photo do
    
  end

  factory :user, aliases: [:author] do
    sequence(:first_name) { |n| "Foo#{n}" }
    sequence(:last_name) { |n| "Barr#{n}" }
    email { "#{first_name}@hotmail.com" }
    password "password"
    password_confirmation "password"
  end

  factory :profile do
    birth_month "12"
    birth_day "28"
    birth_year "2006"
    gender "Female"
    user

  end

  factory :post do
    content "Lorem ipsum dolor sit amet, errem possim delicatissimi cu sea, cu petentium contentiones vim. Ex vim falli exerci, invidunt neglegentur in mea. Eam ex justo quando, nec choro tritani oporteat no, malis omnes has te. Mea probo vivendum accommodare ne, te his ubique vituperatoribus."
    user
  end

  factory :like do
    post
    user
  end

  factory :comment do
    body "Lorem ipsum dolor sit amet, errem possim delicatissimi cu sea, cu petentium contentiones vim. Ex vim falli exerci, invidunt neglegentur in mea. Eam ex justo quando, nec choro tritani oporteat no, malis omnes has te. Mea probo vivendum accommodare ne, te his ubique vituperatoribus."
    author
    post
  end

end