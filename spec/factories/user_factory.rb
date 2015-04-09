FactoryGirl.define do
  factory :user, aliases: [:profile_owner, :author, :commenter, :liker] do
    email "schwad@schwad.com"
    password "greybull"
    first_name "tim"
    last_name "smith"
  end

end