class Photo < ApplicationRecord
  belongs_to :user

  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_attached_file :avatar, :styles => { :medium => "120x120", :thumb => "50x50" }
  # You'll want to make sure you've whitelisted only acceptable
  # content types to avoid attacks
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

   # Individual validation method 1 (validates)
  validates :avatar, :attachment_presence => true

  # Get the picture from a given url.
  # Check to make sure the 'rest-open-uri' is in your gemfile first
  def picture_from_url(url)
      self.picture = open(url)
  end
end
