class Post < ApplicationRecord

  belongs_to :user
  include Liking
  include Commenting

  validates :user_id, :user, :body, presence: true

  def self.display_in_activity(users)
    where(user: users)
    .includes(:user,
      likes: [:user],
      comments: [:user,
        likes: [:user]])
    .order(created_at: :DESC)
  end

end
