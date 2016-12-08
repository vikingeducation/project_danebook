class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validates_presence_of :first, :last, :birthday, :gender

end
