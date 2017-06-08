class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  def full_name
    first_name + " " + last_name
  end

end
