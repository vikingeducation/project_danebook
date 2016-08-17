class Post < ActiveRecord::Base
  belongs_to :author, foreign_key: :author_id, class_name: "User"
  has_many :comments
  has_many :likes, :as => :likable
  validates :body, presence: true
end
