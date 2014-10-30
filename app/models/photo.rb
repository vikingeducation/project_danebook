require 'open-uri'

class Photo < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :large => "500x500", :thumb => "262x262" }

  validates_attachment_content_type :image, :content_type => [ "image/jpeg",
                                                               "image/gif",
                                                               "image/png" ]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 1.megabytes

  attr_accessor :url

  def url=(url)
    picture_from_url(url)
  end

  def picture_from_url(url)
    self.picture = open(url)
  end
end
