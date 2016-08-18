class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :postings, as: :postable
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  has_many :comments

  validates_length_of :description, maximum: 500
end
