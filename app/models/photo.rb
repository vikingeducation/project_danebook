class Photo < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, styles: { medium: "250x250", large: "500x500" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :photo, presence: true
  validates_with AttachmentSizeValidator, attributes: :photo, less_than: 5.megabytes

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :user, presence: true

  def photo_from_url(url)
    self.photo = open(url)
  end
end
