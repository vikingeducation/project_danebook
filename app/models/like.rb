class Like < ActiveRecord::Base
  validates :user_id, :likable_id, :likable_type, presence: true
  validates :user_id, uniqueness: { scope: [:likable_id, :likable_type] }

  belongs_to :user
  has_one :profile, through: :user

  belongs_to :likable, :polymorphic => true

  
  def self.display_likes_msg(likable)
    return nil if likable.likes.empty?
    creator_name(likable.likes) + like_msg_base(likable.likes)      
  end

  def self.creator_name(like_list)
    str = like_list.includes(:profile).inject("") do |str, like|
      str + "#{like.user.profile.full_name} and "
    end
    str[0..-5]
  end

  def self.like_msg_base(like_list)
    num = like_list.count
    if num <= 2
      "like".pluralize(num) + " this."
    else
      "and #{num - 2} " + "other".pluralize(num-2) + " this."
    end

  end

end
