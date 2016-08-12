class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end
end
