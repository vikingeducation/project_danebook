class Photo < ApplicationRecord
  attr_reader :image_remote_url
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :image, styles: { medium: '300x300', thumb: '200x150'}
  has_many :likes, as: :likeable, dependent: :destroy

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :image, presence: true

  include Reusable

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
  end

  def upload_date
    self.image_updated_at.strftime('%-d %B %Y')
  end
end
