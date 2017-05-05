class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable,  dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :comment_likes, through: :comments
  validates :body, presence: true

  include Reusable

  # def liked_by?(user)
  #   return false unless user
  #   ! self.likes.where('user_id = ?', user.id).blank?
  # end

  # def post_likes(user)
  #   return '' unless self.likes_count
  #   msg = ''
  #   if self.liked_by?(user)
  #     msg += 'You'
  #     remaining_likes = self.likes.where('user_id IS NOT ?', user.id).order('created_at DESC')
  #     case
  #     when self.likes_count == 1
  #       msg += ' like this'
  #     when self.likes_count == 2
  #       msg += ' and ' + remaining_likes.first.user.full_name + 'like this'
  #     when self.likes_count == 3
  #       msg += ', ' + remaining_likes.first.user.full_name + ' ' + 'and' + remaining_likes.second.user.full_name + ' like this'
  #     when self.likes_count > 3
  #       msg += ', ' + remaining_likes.first.user.full_name + ' and ' + (self.likes_count - 3).to_s + ' others like this'
  #     end
  #   else
  #     likes = self.likes.includes(:user)
  #     case
  #     when self.likes_count == 1
  #       msg += likes.first.user.full_name + ' likes this'
  #     when self.likes_count == 2
  #       msg += likes.first.user.full_name + ' and ' + likes.second.user.full_name + ' like this'
  #     else
  #       msg += self.likes_count.to_s + ' likes'.pluralize(self.likes_count) if self.likes_count > 0
  #     end
  #   end
  #   msg
  # end


end
