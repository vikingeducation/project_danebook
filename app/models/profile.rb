class Profile < ApplicationRecord

  # validates :first_name,
  #           :length => { :in => 1..40 }

  # validates :last_name, 
  #           :length => { :in => 1..40 }

  belongs_to :user

  def remove_photo(id)
    if profile_photo_id == id
      profile_photo_id = nil
    elsif cover_id == id
      cover_id = nil
    end
  end

end
