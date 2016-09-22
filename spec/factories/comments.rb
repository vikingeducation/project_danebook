FactoryGirl.define do
  factory :comment do
      content "BLAH!!"
      association :commentable, factory: :post

      factory :comment_comment do 
        association :commentable, factory: :comment
      end
  end
end