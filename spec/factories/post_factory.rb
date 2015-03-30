FactoryGirl.define do

  factory :post, aliases: [:parent_post] do 
    author
    content "This is my content on a post"
  end

end