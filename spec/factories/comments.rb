FactoryBot.define do

  # factory :comment do
  #   user
  # end

  factory :comment_on_post, class: Comment do
    body "this is a comment on a post"
    user
    association :commentable, factory: :post
  end

  # commenting on comments has not been implemented yet
  factory :comment_on_comment, class: Comment do
    body "this is a comment on a comment"
    user
    association :commentable, factory: :comment_on_post
  end


end #FactoryBot
