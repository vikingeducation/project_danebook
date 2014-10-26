class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, :as => :likable
  has_many :comments, :as => :commentable

  def self.get_author(post)
   @user = User.find(post.user_id)
   "#{@user.first_name} #{@user.last_name}"
  end

end
