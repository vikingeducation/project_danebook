class Comment < ActiveRecord::Base
  has_many :likes, :as => :likable
  belongs_to :commentable, :polymorphic => true



  def self.get_author(comment)
   @user = User.find(comment.user_id)
   "#{@user.first_name} #{@user.last_name}"
  end
end
