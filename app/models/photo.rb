require 'open-uri'

class Photo < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :user

  has_many :users_with_profile_pics, foreign_key: :profile_pic,
                                      class_name: "User"

  has_many :users_with_cover_photos, foreign_key: :cover_photo,
                                      class_name: "User"

  has_attached_file :data,
                    styles: { medium: "200x200>",
                              thumb: "150x150>",
                              cover: "800x450>" },
                    default_url: "/images/icon_photo_small.png"

  process_in_background :data # Delayed Paperclip Upload

  include Likeable

  include Commentable

  # ----------------------- Validations --------------------

  validates_attachment_content_type :data,
                                    :content_type => /\Aimage\/.*\Z/

  validates :user_id, :data,
            presence: true

  # ----------------------- Methods --------------------

  def pic_from_url(url)
    self.data = open(url)
  end

end
