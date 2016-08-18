FactoryGirl.define do
  factory :friending do
    
  end

  factory :user do
    email "foobar@foo.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :post do
    post_receiver_id 1
    body "Post body"
  end

  factory :like do
    likeable_id 1
    factory :comment_like do
      likeable_type "Comment"
    end
    factory :post_like do
      likeable_type "Post"
    end
  end

  factory :profile do
    first_name "Foo"
    last_name "Bar"
    college "Baz State"
    hometown "Boston"
    currently_lives "Boston"
    words_to_live_by "hello hello hello"
    about_me "goodbye goodbye goodbye"
    telephone "1234567890"
  end

  factory :comment do
    body "Test comment"
    commentable_id 1
    commentable_type "Post"
  end



   




end