class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :post
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likable, dependent: :destroy
  validates :text, presence: true
  def commented_on
    self.created_at.strftime("Said on %A, %b %d %Y")
  end
end
