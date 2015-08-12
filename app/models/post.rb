class Post < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..400 }

  belongs_to :user
  has_one :profile, through: :user

  has_many :comments, 
           :as => :commentable,
           :dependent => :destroy
  has_many :likes, 
           :as => :likable, 
           :dependent => :destroy

  # concerns to get id of the like on this likable object    
  include GetLikeID
end
