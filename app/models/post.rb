class Post < ApplicationRecord
  belongs_to :user

  validates :description, length: {minimum: 1}
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"

  has_one :photo, :as => :photoable, class_name: "Photo", inverse_of: :photoable
  accepts_nested_attributes_for :photo

  def already_likes?
    self.likes.empty? ? false : true
  end

  def has_photo?
    self.photo.nil? ? false : true
  end

end
