require 'open-uri'

class Photo < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :user

  has_attached_file :photo,
                    styles: { medium: "200x200>",
                              thumb: "150x150>" },
                    default_url: "/images/icon_photo_small.png"

  # ----------------------- Validations --------------------

  validates_attachment_content_type :photo,
                                    :content_type => /\Aimage\/.*\Z/

  validates :user_id, :photo,
            presence: true

  # ----------------------- Methods --------------------

  def pic_from_url(url)
    self.photo = open(url)
  end

end
