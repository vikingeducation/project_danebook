class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likable, :polymorphic => true

  validates :user_id, uniqueness: { scope: [:likable_id, :likable_type] }
  
  def self.display_likes_msg(likable)
    return nil if likable.likes.empty?
    creator_name(likable.likes) + like_msg_base(likable.likes)      
  end

  def self.creator_name(like_list)
    str = like_list.inject("") do |str, like|
      str + "#{like.user.profile.full_name} and "
    end
    str[0..-5]
  end

  def self.like_msg_base(like_list)
    case 
    when like_list.count == 1
      "likes this."
    when like_list.count == 2
      "like this."
    when like_list.count == 3
      "and 1 other like this."
    when like_list.count > 3
      "and #{like_list.count - 2} others like this."
    end

  end

end
