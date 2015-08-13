class Like < ActiveRecord::Base

  #=================== associations =========================

  belongs_to :likings, :polymorphic => true
  belongs_to :user

  #=================== validations =========================

  validates :user_id,
          uniqueness: { scope: [:likings_id, :likings_type]}
  validates :likings_id, :likings_type, :presence => :true

  #=================== class methods =========================

  def self.recent_likes
    order("created_at DESC").limit(2)
  end

  def self.recent_users_like
    recent_likes.first.user if self.like_count >0
  end

  def self.like_count
    count
  end

  def self.you_liked?(current_user)
    where("user_id = ?", current_user.id).any?
  end

  #=================== instance methods =========================

  def like_list(likings_type, likings_id)
    where( "likings_type = ? AND likings_id = ?",
                  likings_type, likings_id)
  end


end
