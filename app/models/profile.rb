class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  validates :birthday, :first_name, :last_name, presence: true, allow_nil: false
  validates :first_name, :last_name, length: { in: 3..30 }

  def name
    first_name + " " + last_name
  end

  def name=(name)
    full = name.split(" ")
    first_name = full.first
    last_name = full.last
  end

end
