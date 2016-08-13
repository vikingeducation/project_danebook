class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :likes, as: :likable

  validates :text, length: { in: (1..1000) }
end
