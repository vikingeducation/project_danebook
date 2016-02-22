FactoryGirl.define do
  factory :photo do
    
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@email.com"}
    password "password"
    first_name "First"
    last_name "Last"
  end


  factory :profile do
    about_me "Things that make me seem cool"
    words_to_live_by "Seize the carp"
    current_city "San Francisco"
    hometown "Godricks Hollow"

    user
  end


  factory :friending do
    friender_id 1
    friend_id 2
  end


  factory :post do
    user_id 1
    body "This is my post body"
  end


  factory :comment do
    body "This is my comment body"
    user_id 10
    post_id 4
  end


  factory :post_like, class: :like do
    user_id 8
    likeable_id 3
    likeable_type "Post"
  end


  factory :comment_like, class: :like do
    user_id 8
    likeable_id 3
    likeable_type "Comment"
  end



end