FactoryGirl.define do
  factory :friend_request do
    approved nil
    association :initiator, :factory => :user
    association :approver, :factory => :user
  end
end

