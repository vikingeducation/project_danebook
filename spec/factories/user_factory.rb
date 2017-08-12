FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "Marek_#{n}@factory.com" }
    password "loko12"
  end   

  factory :profile do
    sequence(:first_name){ |n| "Marek#{n}"}
    sequence(:last_name){ |n| "O'Neill#{n}"}
    sequence(:birth_day){ |n| "#{n}"}
    sequence(:birth_month){ |n| "#{n}"}
    sequence(:birth_year){ |n| "#{n + 1970 }"}
    sequence(:gender){ |n| ["male", "female"][rand(2)]}
    sequence(:college){ |n| "Trinity College no#{n}"}
    sequence(:hometown){ |n| "Miami#{n}"}
    sequence(:current_town){ |n| "New York#{n}"}
    sequence(:telephone){ |n| "#{n + 12345678}"}
    sequence(:words_to_live){ |n| "#{n} lives but only #{n+3} chances. #{n+1} ideas but only one conclusion."}
    sequence(:about_me){ |n| "I am #{n+12} years old. I love bowling."}
    user
  end

  factory :post do
    sequence(:body){ |n| "Hey, my new body - #{n}"}
    user
  end

  factory :comment  do
    association :commentable, factory: :post
    sequence(:body){ |n| "This is my comment number #{n}, and I am not going to stop! "}
    user
  end

  factory :post_like, :class => 'Like' do
    association :likeable, factory: :post
    user
  end

  factory :comment_like, :class => 'Like' do
    association :likeable, factory: :comment
    user
  end

end
