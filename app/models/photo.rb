class Photo < ApplicationRecord
  has_attached_file :picture, styles: { medium: "600x600>", thumb: "150x150>" }, default_url: "/images/style/missing.jpeg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates :picture, attachment_presence: true
  validates_with AttachmentSizeValidator, attributes: :picture, less_than: 0.5.megabytes

  belongs_to :user

  def from_url(url)
    self.picture = URI.parse(url)
  rescue => error
    errors.add(:url, "is invalid.")
  end

  def has_no_errors?
    self.errors.full_messages.empty? ? true : false
  end
end
