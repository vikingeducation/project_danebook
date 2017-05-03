class Photo < ApplicationRecord
  attr_reader :image_remote_url
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :image,
    styles: { medium: '300x300', avatar: '150x150#', cover: '900x300', thumb: '36x36', small: '200x150'},
    default_url: ':style_missing.png'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

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
