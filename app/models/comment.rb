class Comment < ApplicationRecord
  belongs_to :posts
  belongs_to :users

  validates :body, presence: true

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end

end
