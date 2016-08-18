class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :postings, as: :postable
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  has_many :comments

  has_attached_file :file, :styles => { :large => "600x600", :medium => "300x300", :thumb => "100x100" }

  validates_length_of :description, maximum: 500
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
