FactoryGirl.define do
  factory :post, aliases: [:commentable, :likeable] do
    body "this is some comment" 
  end
end 