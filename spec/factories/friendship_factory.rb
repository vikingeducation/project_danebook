FactoryGirl.define do
  factory :friendship do
    association :initiator, :factory => :user
    association :approver, :factory => :user
  end
end