FactoryGirl.define do

  factory :comment, aliases: [:parent_comment] do
    commenter
    parent_post
    content "this is my content it does what I tell it to"
  end

end
