class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true

  def date
    self.created_at.strftime('%A, %d %B %Y') if self.created_at
  end
end
