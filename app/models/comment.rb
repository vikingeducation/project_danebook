class Comment < ApplicationRecord

  has_many :likes, as: :likable_thing, dependent: :destroy
  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true

end
