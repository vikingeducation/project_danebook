class Profile < ApplicationRecord

  belongs_to :user, optional: true

  belongs_to :profile_photo, class_name: "Photo", optional: true
  belongs_to :cover_photo, class_name: "Photo", optional: true

  def birthday
    "#{month}\/#{day}\/#{year}"
  end

  def birthday=(datestring)
    date = datestring.split('\/')
    self.month = date[0]
    self.day = date[1]
    self.year = date[2]
  end

end
