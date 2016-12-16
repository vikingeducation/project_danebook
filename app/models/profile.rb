class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  # validates :first_name, :last_name, presence: true,
                                    #  length: { maximum: 20 }

  # validates :motto, :about, length: { maximum: 600 }
  # validates :gender, presence: true
  # validates :phone, length: { maximum: 10 }, :format => /[0-9]/
end
