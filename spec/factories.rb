require 'rails_helper'

FactoryGirl.define do

  factory :user, aliases: [:friend_recipient, :friend_initiator] do

    sequence(:first_name){ |n| "Foo#{n}"}
    email    { "#{first_name}@bar.com"}
    last_name "bar"
    password "password"
    password_confirmation "password"
    birthdate   {Date.parse('20-10-2000')}

  end

  factory :post_like, class: "Like" do
    association :likings, :factory => :post
  end

  factory :comment_like, class: "Like" do
    association :likings, :factory => :post_comment
  end


  factory :post_comment, class: "Comment" do
    association :commentable, :factory => :post

    body  "something in post body"
    user
  end

  factory :post do
    body  "something in post body"

    user
  end

  #User self-association join table
  factory :friending do
    :friend_recipient
    :friend_initiator
  end

  factory :photo do
    file_name
    content_type
    file_size
    created_at

    user
  end


  factory :profile do
    college     "Some College"
    hometown    "Obscure Hometown"
    location    "Knowhere"
    phone       "111-111-1111"
    motto       "Do or Do Not"
    about       "lorem stuff here"
    gender      "male"

    user
  end

end