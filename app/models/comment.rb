class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likeable, :dependent => :destroy
  belongs_to :commentable, polymorphic:true

  validates :body, presence: true

  def posted_date
    updated_at.strftime("%A %m/%d/%Y")
  end

end
