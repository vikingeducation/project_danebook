FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence( :email ) { |n| "user#{n}@email.com" }

    password "password"
  end

  factory :post do
    body "I'm the body of a post, yes"

    author
  end

  factory :comment do
    body "I'm the body of a comment !"

    post
    author
  end

  factory :profile do
    first_name "first_name"     
    last_name "last_name"      
    birth_month "birth_month"    
    birth_day "birth_day"      
    birth_year "birth_year"     
    gender "gender"         
    college "college"        
    hometown "hometown"       
    current_address "current_address"
    phone "phone"          
    my_words "my_words"       
    about_me "about_me"   

    user     
  end

end