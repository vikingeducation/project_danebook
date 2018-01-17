FactoryBot.define do


  # factory :comment do
  #   user
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
