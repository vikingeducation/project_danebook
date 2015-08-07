class Post < ActiveRecord::Base
  has_many :likes, :as => :likeable
  has_many :comments
  belongs_to :user
  validates :user_id, :body,
            :presence => :true
end
