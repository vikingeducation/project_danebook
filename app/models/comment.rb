class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commentable, class_name: "Comment", foreign_key: :commentable_id, dependent: :destroy
  belongs_to :commentable, polymorphic: true

  include Commentable

  def nested_comments
    Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  end

end
