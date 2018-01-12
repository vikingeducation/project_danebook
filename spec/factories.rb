FactoryBot.define do

  factory :user do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@example.com" }
    password 'password'
  end

  factory :post do
    body "this is the post body"
    user
  end #post

  # factory :comment do
  #   body "Foo Comment Body"
  #   user   # association!
  #   # to make comments for other types of commentables,
  #   # use a nested factory
  #   association :commentable, factory: :post
  # end

  factory :comment_on_post, class: Comment do
    body "this is a comment on a post"
    user   # association!
    association :commentable, factory: :post
  end

  factory :comment_on_comment, class: Comment do
    body "this is a comment on a comment"
    user   # association!
    association :commentable, factory: :comment_on_post
  end


end #FactoryBot
