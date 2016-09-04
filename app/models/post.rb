class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  def has_post?
    !self.posts.empty?
  end
end
