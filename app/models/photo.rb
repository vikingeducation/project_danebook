class Photo < ApplicationRecord
  belongs_to :user

  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }
  # You'll want to make sure you've whitelisted only acceptable
  # content types to avoid attacks
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
