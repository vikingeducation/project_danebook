class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activable, polymorphic: true
  validates :user, :activable, presence: true

  def self.friend_feed(user=nil)
    return nil unless user
    Activity.limit(10).order('created_at DESC').where('user_id IN (?)', user.friendee_ids).includes(user: [:profile])
  end

  def date
    self.created_at.strftime('%A, %-d %B %Y') if self.created_at
  end

  def to_text
    case self.activable_type
    when 'Post'
      'Created a post'
    when 'Photo'
      'Uploaded a photo'
    when 'Comment'
      'Wrote a comment'
    when 'Like'
      "Liked a #{self.activable.likeable_type.downcase}"
    end
  end

end
