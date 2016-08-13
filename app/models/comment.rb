class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, :as => :likeable
  
  validates :body, presence: true

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end

end
