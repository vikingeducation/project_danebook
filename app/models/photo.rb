class Photo < ApplicationRecord
  attr_reader :image_remote_url
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :image,
    styles: {  small: '200x150'},
    default_url: ':style_missing.png'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates_attachment :image,
    presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/},
    size: { in: 0..3.megabytes}

  include Reusable

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value)
  end

  def upload_date
    self.image_updated_at.strftime('%-d %B %Y')
  end
end
