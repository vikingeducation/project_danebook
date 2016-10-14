class Post < ApplicationRecord
  validates :text, length: { maximum: 500 }, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy


  def posted_on
    self.created_at.strftime("Posted on %A, %b %d %Y")
  end

  def posted_ago
    time_ago_in_words(self.created_at)
  end
end
