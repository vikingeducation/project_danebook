class Like < ActiveRecord::Base
  belongs_to :likeable, :polymorphic => true
  belongs_to :user
  # user_id is unique for each post
  validates :user_id, :uniqueness => {:scope => [:likeable_id, :likeable_type]}
  # validates :post, :user, :presence => true
  validates :user_id, :presence => true

  def self.find_liked_object(object, current_user)
    Like.where(:likeable_id => object.id).
         where(:likeable_type => object.class).
         where(:user_id => current_user.id).first
  end
end
