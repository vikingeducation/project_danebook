class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  #after_validation { first_name.strip.titleize ; last_name.strip.titleize }

  validates :gender, :first_name, :last_name, presence: true


#whitelist valid letters (ie no numbers/symbols)

end
