FactoryGirl.define do

  factory :like do
    liker
    parent_post
    # parent_comment for comment liking implementation later
  end

end