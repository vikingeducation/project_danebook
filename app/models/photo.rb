class Photo < ApplicationRecord
  has_attached_file :image, :styles => {
                            :thumb => "100x100",
                            :small  => "150x150",
                            :medium => "200x200" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  def image_from_url(url)
    self.image = open(url)
  end
end
