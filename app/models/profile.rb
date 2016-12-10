class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  #after_validation { first_name.strip.titleize ; last_name.strip.titleize }

  # before_save { self.first_name.downcase!.strip! }
  # before_save { self.last_name.downcase!.strip! }
  #
  # validates :first_name, :last_name, presence: true,
  #                                    length: { maximum: 20 },
  #                                    :format => /[a-z]\s[a-z]/



  #
  # validates :motto, :about,
  #                 length: { maximum: 20 },
  # validates :gender,
  # validates :phone


#whitelist valid letters (ie no numbers/symbols)

end
# validates :email, presence: true,
#                   length: { maximum: 255 },
#                   :format => /@/,
#                   uniqueness: { case_sensitive: false }
