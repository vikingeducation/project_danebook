class Comment < ActiveRecord::Base
  validates :body, 
            :user_id, 
            :commentable_id, 
            :commentable_type, 
            presence: true
  validates :body, length: { in: 1.. 140 }

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_one :profile, through: :user

  has_many :likes, 
           :as => :likable, 
           :dependent => :destroy

  # concerns to get id of the like on this likable object      
  include GetLikeID
end
