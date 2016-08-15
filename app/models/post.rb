class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"

end
