class Profile < ApplicationRecord
  belongs_to :user

  def name
    first_name + ' ' + last_name if first_name && last_name
  end
end
