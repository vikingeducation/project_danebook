class Comment < ActiveRecord::Base
  validates :user_id, :presence => :true
  has_many :likes, :as => :likeable
  belongs_to :user
  belongs_to :likeable, :polymorphic => true
  # validates :user_id, :presence => :true
end
