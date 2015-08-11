# spec/factories.rb
FactoryGirl.define do  factory :photo do
    
  end

  # A block defining the attributes of a model
  # The symbol is how you will later call it
  # Factory Girl assumes that your class name
  # is the same as the symbol you passed
  # (so here, it assumes this is a User)
  factory :user do
    sequence(:first_name) { |n| "Foo#{n}" }
    last_name                   "Bar"
    email                     { "#{first_name}#{last_name}@bar.com" }
    password                    "password"
    password_confirmation       "password"
    birthday                    Date.today - 5000
    gender                      ["male", "female"].sample
  end

  factory :profile do
    college         "South American University"
    hometown        "My Town"
    current_home    "A Town"
    mobile          "1234"
    summary         "Words words"
    about           "More words!"
    association     :user, :factory => :user
  end

  factory :post do
    body            "Lots of text!"
    association     :author, :factory => :user
    association     :recipient_user, :factory => :user
  end

  factory :friending do
    association     :friend_initiator,   :factory => :user
    association     :friend_recipient, :factory => :user
  end


  factory :post_comment, class: "Comment" do
    association     :author, :factory => :user
    body            "Lots of text!"
    association     :commentable, :factory => :post
  end

  factory :comment_comment, class: "Comment" do
    association     :author, :factory => :user
    body            "Lots of text!"
    association     :commentable, :factory => :post_comment
  end

  factory :post_like, class: "Like" do
    association     :user, :factory => :user
    association     :likeable, :factory => :post
  end

  factory :comment_like, class: "Like" do
    association     :user, :factory => :user
    association     :likeable, :factory => :post_comment
  end

end