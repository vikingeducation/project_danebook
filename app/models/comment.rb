class Comment < ActiveRecord::Base

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy


  validates :body, length: { in: 1..250 }, presence: true




  def self.send_new_comment_email(id)
    comment = Comment.find(id)
    CommentMailer.new_comment(comment).deliver!
  end

end
