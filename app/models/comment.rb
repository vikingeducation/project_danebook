class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: "User", foreign_key: :commenter_id

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :text, length: { in: (1..1000) }

  def parent_user
    if self.commentable.class == Post
      return self.commentable.author
    else
      return self.commentable.user
    end
  end
end
