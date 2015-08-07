class Like < ActiveRecord::Base

  belongs_to :user, :foreign_key => :liker_id
  #belongs_to :post, :foreign_key => :liked_id
  belongs_to :liked, :polymorphic => true

end
