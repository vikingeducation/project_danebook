class Post < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..400 }

  belongs_to :user

  has_many :comments, :dependent => :destroy
  has_many :likes, :as => :likable, :dependent => :destroy

  
end
