class Post < ApplicationRecord

  belongs_to :user

  validates :content, length: { minimum: 1 }

  def self.reversed
    Post.order(created_at: :desc)
  end

end
