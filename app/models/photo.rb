require "open-uri"

class Photo < ActiveRecord::Base

  has_attached_file :picture, :styles => {large: "1000X1000",
                                          thumb: "100x100"}

  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :picture, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :picture
  validates_with AttachmentSizeValidator, :attributes => :picture,
                                          :less_than => 1.megabytes

  validates :user_id, :presence => true

  #=================== other associations =========================

  belongs_to :user

  has_one :cover_pic_user,  class_name: "User",
                            foreign_key: :cover_photo_id,
                            dependent: :nullify

  has_one :profile_pic_user,  class_name: "User",
                              foreign_key: :profile_photo_id,
                              dependent: :nullify

  has_many :likes, as: :likings, class_name: "Like",
            dependent: :destroy

  has_many :comments, as: :commentable, class_name: "Comment",
            dependent: :destroy

  #========================= methods =========================

  def picture_from_url(url)
    begin
      self.picture = open(url)
    rescue
      return flash = {:error => "Problems with that link"}
    end
  end

  #virtual attribute writer
  def photo_link=(photo_link)
    self.picture_from_url(photo_link) unless photo_link.nil?
  end

  #virtual attribute reader (to keep form_for from complaining)
  def photo_link
    # raise NotImplementedError
    #something to read from, not used in code
  end

  private

   def self.photo_exists?(id)
    where("id = ?", id.to_i).any?
  end

end