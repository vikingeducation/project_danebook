class Comment < ActiveRecord::Base
  has_many :likes, :as => :likeable
  belongs_to :user
  belongs_to :post
  validates :user_id, :presence => :true
end
