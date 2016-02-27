# spec/factories.rb
FactoryGirl.define do

  factory :photo_attributes do
    data_file_name        "beast.png"
    data_content_type     "image/png"
    data_file_size        27720
    data_updated_at       Date.today
    association           :user, factory: :user
    img_url               ""
  end

  factory :photo do
    user
    data { fixture_file_upload(Rails.root.join('spec', 'photos', 'pic.jpg'), 'image/jpg') }
    img_url   ""
  end

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
    association     :friender,    :factory => :user
    association     :target,      :factory => :user
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