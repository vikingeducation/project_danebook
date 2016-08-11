class Profile < ApplicationRecord
  belongs_to :user, optional: :required
end
