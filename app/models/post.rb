class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..250 }


  def self.newsfeed(user)
    where('user_id IN (?) OR user_id IN (?) OR user_id = ?',
      user.friended_users.pluck(:id),
      user.users_friended_by.pluck(:id),
      user.id
      ).order(created_at: :desc)
  end


end
