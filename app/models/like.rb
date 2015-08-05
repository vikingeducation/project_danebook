class Like < ActiveRecord::Base

  belongs_to :likings, :polymorphic => true
  belongs_to :user

  # validates :likings_id, :likings_type, :presence => :true



  def self.recent_likes
    order("created_at DESC").limit(1)
  end

  def self.recent_user_like
    recent_likes.first.user
  end

  def like_list(likings_type, likings_id)
    where( "likings_type = ? AND likings_id = ?",
                  likings_type, likings_id)
  end

  def like_count
    like_list.count
  end

  def self.you_liked?(current_user)
    where("user_id = ?", current_user.id).any?
  end

end
