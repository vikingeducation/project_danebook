FactoryGirl.define do

	factory :user, aliases: [:initiator, :acceptor] do
		sequence(:first_name) { |n| "foo#{n}" }
		last_name "bar"
		email {"#{first_name}@b.com"}
		gender "female"
		birthday "#{Time.now}"
		password "123456"
		password_confirmation "123456"

		trait :with_profile do
			after(:build) { |user| user.profile = build(:profile)}
		end

	end
end