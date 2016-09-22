class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable, dependent: :nullify

  validates :content, presence: true

  #after_create :commented_by_email

  accepts_nested_attributes_for :comments

  def commented_by_email
    commenter = User.find_by_id(self.from) 
    the_user_id = self.commentable.respond_to?(:from) ?  self.commentable.from : self.commentable.user_id
    to_user = User.find_by_id(the_user_id)
    commentable = self.commentable
    UserMailer.commented_by(commenter, to_user, commentable).deliver! unless commenter == to_user
  end
end
