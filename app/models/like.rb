class Like < ActiveRecord::Base
  belongs_to :likable, :polymorphic => true

  def self.create_like(user,post)
    Like.create!(
      user_id: user.id,
      likable_id: post.id,
      likable_type: "Post"
      )
  end

  def self.create_comment_like(user,comment)
    Like.create!(
      user_id: user.id,
      likable_id: comment.id,
      likable_type: "Comment"
      )
  end


  def self.destroy_like(user,post)
    post.likes.where("user_id = ?",user.id).delete_all
  end

  def self.destroy_comment_like(user,comment)
    comment.likes.where("user_id = ?",user.id).delete_all
  end
end
