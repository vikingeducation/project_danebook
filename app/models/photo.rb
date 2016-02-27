require 'open-uri'

class Photo < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :user

  has_many :users_with_profile_pics,  foreign_key: :profile_pic,
                                      class_name: "User",
                                      dependent: :nullify

  has_many :users_with_cover_photos,  foreign_key: :cover_photo,
                                      class_name: "User",
                                      dependent: :nullify

  has_attached_file :data,
                    styles: { medium: "200x200>",
                              thumb: "150x150>",
                              cover: "800x450>" },
                    default_url: "icon_photo_small.png"

  process_in_background :data,
                        processing_image_url: "https://s3.amazonaws.com/davidmeza/animation_processing.gif"

  include Likeable

  include Commentable

  # ----------------------- Validations --------------------

  validates_attachment_content_type :data,
                                    :content_type => /\Aimage\/.*\Z/

  validates :user_id, :data,
            presence: true

  validates :img_url,
            allow_blank: true,
            url: true,
            image: true

  # ----------------------- Methods --------------------

  def img_url=(url)
    begin
      self.data = open(url)
    rescue OpenURI::HTTPError, Errno::ENOENT
      self.errors[:URL] << "Sorry, did not find the given url. Try a different one"
    end
  end


end
