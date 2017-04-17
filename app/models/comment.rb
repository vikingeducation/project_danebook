class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_likes, dependent: :destroy
  validates :body, presence: true

  include Reusable

  def liked_by(id)
    ! self.comment_likes.where('user_id = ?', id).blank?
  end

  def likers(id)
    return '' unless self.comment_likes_count
    msg = ''
    if self.liked_by(id)
      msg += 'You'
      remaining_likes = self.comment_likes.where('user_id IS NOT ?', id).order('created_at DESC')
      case
      when self.comment_likes_count == 1
        msg += ' like this'
      when self.comment_likes_count == 2
        msg += ' and ' + remaining_likes.first.user.full_name + 'like this'
      when self.comment_likes_count == 3
        msg += ', ' + remaining_likes.first.user.full_name + ' ' + 'and' + remaining_likes.second.user.full_name + ' like this'
      when self.comment_likes_count > 3
        msg += ', ' + remaining_likes.first.user.full_name + ' and ' + (self.comment_likes_count - 3).to_s + ' others like this'
      end
    else
      msg += self.comment_likes_count.to_s + ' likes'.pluralize(self.comment_likes_count) if self.comment_likes_count > 0
    end
    msg
  end




end
