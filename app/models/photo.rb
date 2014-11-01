require 'open-uri'

class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { thumb: "50x50#", small: "100x100#", medium: "200x200#" }
  belongs_to :author, :class_name => "User"

  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author, presence: true
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo, presence: true,
                               size: { :in => 0..2.megabytes }

  attr_accessor :url

  def photo_from_url(url)
    self.photo = open(url)
  end
end
