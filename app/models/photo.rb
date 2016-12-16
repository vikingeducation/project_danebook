  class Photo < ApplicationRecord
  has_attached_file :image, :styles => {
                            :thumb => "64x64",
                            :small  => "150x150",
                            :medium => "200x200",
                            :cover => "940x300"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_one :profile_photo_owner, class_name: "User", foreign_key: :profile_photo_id, dependent: :nullify
  has_one :cover_photo_owner, class_name: "User", foreign_key: :cover_photo_id, dependent: :nullify

  def image_from_url(url)
    self.image = open(url)
  end

  def posted_on
    self.created_at.strftime("Posted on %A, %b %d %Y")
  end

  def posted_ago
    time_ago_in_words(self.created_at)
  end
end
