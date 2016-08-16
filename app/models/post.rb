class Post < ApplicationRecord
  belongs_to :user

  validates :description, length: {minimum: 1}
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"

  def already_likes?
    self.likes.empty? ? false : true
  end

end
