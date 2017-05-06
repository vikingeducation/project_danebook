class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body, presence: true
  validates :user, presence: true
  after_create :queue_notification_email, unless: Proc.new{ self.user_id == self.commentable.user_id }

  include Reusable

  def liked_by?(id)
    ! self.likes.where('user_id = ?', id).blank?
  end

  def likers(id)
    return '' unless self.likes_count
    msg = ''
    if self.liked_by?(id)
      msg += 'You'
      remaining_likes = self.likes.where('user_id IS NOT ?', id).order('created_at DESC')
      case
      when self.likes_count == 1
        msg += ' like this'
      when self.likes_count == 2
        msg += ' and ' + remaining_likes.first.user.full_name + 'like this'
      when self.likes_count == 3
        msg += ', ' + remaining_likes.first.user.full_name + ' ' + 'and ' + remaining_likes.second.user.full_name + ' like this'
      when self.likes_count > 3
        msg += ', ' + remaining_likes.first.user.full_name + ' and ' + (self.likes_count - 3).to_s + ' others like this'
      end
    else
      msg += self.likes_count.to_s + ' likes'.pluralize(self.likes_count) if self.likes_count > 0
    end
    msg
  end

  private

  def queue_notification_email
    UserMailer.comment_notification(self).deliver_later
  end




end
