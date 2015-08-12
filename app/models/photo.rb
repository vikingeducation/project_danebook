require "open-uri"

class Photo < ActiveRecord::Base

  has_attached_file :picture, :styles => {large: "1000X1000",
                                          thumb: "100x100"}

  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  validates :user_id, :presence => true

  belongs_to :user

  has_one :cover_pic_user,  class_name: "User",
                            foreign_key: :cover_photo_id
  has_one :profile_pic_user,  class_name: "User",
                              foreign_key: :profile_photo_id

  has_many :likes, as: :likings, class_name: "Like",
            dependent: :destroy

  has_many :comments, as: :commentable, class_name: "Comment",
            dependent: :destroy


  def picture_from_url(url)
    self.picture = open(url)
  end

  def photo_link
    #something to extract from
  end

  #virtual attribute
  def photo_link=(photo_link)
    self.picture_from_url(photo_link)
  end
end
