class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  def name
    first_name + " " + last_name
  end

  def name=(name)
    full = name.split(" ")
    first_name = full.first
    last_name = full.last
  end 

end
