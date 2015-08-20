require 'open-uri'

class Photo < ActiveRecord::Base

  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :less_than => 2.megabytes

  belongs_to :owner, :class_name => 'User'


  attr_accessor :photo_from_url

  def photo_from_url=(url = "")
    self.photo = open(url) unless url.empty?
  end

end
