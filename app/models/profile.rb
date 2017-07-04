class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile
  belongs_to :profile_photo,
             optional: true,
             class_name: "Photo",
             foreign_key: :profile_photo_id
  belongs_to :cover_photo,
             optional: true,
             class_name: "Photo",
             foreign_key: :cover_photo_id


  def full_name
    first_name + " " + last_name
  end

end
