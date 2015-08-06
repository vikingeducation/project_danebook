class Comment < ActiveRecord::Base
  validates :body, :user_id, :post_id, presence: true
  validates :body, length: { in: 1.. 140 }

  belongs_to :user
  belongs_to :post

  has_many :likes, :as => :likable

end
