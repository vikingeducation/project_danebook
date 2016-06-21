class Comment < ActiveRecord::Base
  belongs_to :post

  belongs_to :author, class_name: "User",
                      foreign_key: :user_id

  has_many :likings, as: :likeable
  has_many :users_liked, through: :likings, source: :user
  
  validates :post, :author, presence: true 
  validates :body, :user_id, :post_id, presence: true               

  def nb_user_like(liked)
    first_user_liked.full_name + (liked-1 > 0 ? ( " and " + pluralize(liked-1, "User") ) : "") 
  end

  def first_user_liked
    self.users_liked.first
  end

end
