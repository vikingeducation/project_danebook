class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def self.current_user_like(post, current_user)
    where("user_id = :user_id AND likeable_id = :likeable_id AND likeable_type = :likeable_type", {user_id: current_user.id, likeable_id: post.id, likeable_type: 'Post'}).first
  end
end
