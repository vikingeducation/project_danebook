class Photo < ActiveRecord::Base
  
  has_attached_file :photo_data, :styles => { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :photo_data, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments, :as => :commentable


end
