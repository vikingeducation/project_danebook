class Photo < ApplicationRecord
  has_many :users

  has_many :postings, as: :postable, dependent: :destroy
  has_many :authors, through: :postings, source: :user

  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :commenters, through: :comments, source: :user

  has_many :likes, :as => :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :file, :styles => { :large => "600x600", :medium => "300x300", :thumb => "100x100" }

  validates_length_of :description, maximum: 500
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  def to_s
    "photos"
  end
end
