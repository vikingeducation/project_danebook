class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  has_many :likes

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end
  
end
