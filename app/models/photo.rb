class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_attached_file :image, :styles => { :large => "400x400#",
                                         :medium => "200x200#", 
                                         :thumb => "100x100#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :image, :user, :image_file_name

  attr_accessor :url, :profile_photo

  def picture_from_url(url)
    self.image = open(url)
  end
end

