class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  accepts_nested_attributes_for :user
end
