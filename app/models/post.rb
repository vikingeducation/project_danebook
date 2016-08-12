class Post < ActiveRecord::Base

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body, length: { minimum: 1 }
end
