class Like < ActiveRecord::Base

  belongs_to :likings, :polymorphic => true

  # validates :likings_id, :likings_type, :presence => :true

  def recent_likes(likings_type, likings_id)
    Like.where( "likings_type = ? AND likings_id = ?",
                  likings_type, likings_id).order("created_at DESC")
  end

end
