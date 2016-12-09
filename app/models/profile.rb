class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, inverse_of: :profile
end