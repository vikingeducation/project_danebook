class Comment < ApplicationRecord
  belongs_to :user , foreign_key: :user_id
  has_many :likes, as: :likeable, dependent: :destroy 
  belongs_to :commentable, polymorphic: true

  validates :body, 
            length: { minimum: 8 }

  def self.send_email(user_id)
    user = User.find(user_id)
    CommentMailer.commented_on(user).deliver!
  end
end
