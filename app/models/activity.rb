class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :activable, polymorphic: true
  validates :user, :activable, presence: true

  def self.recently_active(user=nil)
    return nil unless user
    Activity.limit(10).order('created_at DESC').where('user_id IN (?)', user.friendee_ids).includes(user: [:profile])
  end

  def self.newsfeed(user=nil)
    return nil unless user
    Activity.where('(activable_type = ? OR activable_type = ? ) AND user_id IN (?)', 'Photo', 'Post', user.friendee_ids.clone << user.id ).order('created_at DESC').includes(activable: [:user])
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
