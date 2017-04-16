class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :body, presence: true

  def date
    self.created_at.strftime('%A, %d %B %Y') if self.created_at
  end

  def liked_by(id)
    ! self.likes.where('user_id = ?', id).blank?
  end

  def post_likes(current_user)
    # always two names
    # You, x and z like
    # You and x like this post
    # X and Y like this post
    return '' unless self.likes_count
    msg = ''
    if self.liked_by(current_user.id)
      msg += 'You'
      remaining_likes = self.likes.where('user_id IS NOT ?', current_user.id).order('created_at DESC')
      case
      when self.likes_count == 1
        msg += ' like this'
      when self.likes_count == 2
        msg += ' and ' + remaining_likes.first.user.full_name + 'like this'
      when self.likes_count == 3
        msg += ', ' + remaining_likes.first.user.full_name + ' ' + 'and' + remaining_likes.second.user.full_name + ' like this'
      when self.likes_count > 3
        msg += ', ' + remaining_likes.first.user.full_name + ' and ' + (self.likes_count - 3).to_s + ' others like this'
      end
    else
      msg += self.likes_count.to_s + ' likes'.pluralize(self.likes_count) if self.likes_count > 0
    end
    msg
  end


end
