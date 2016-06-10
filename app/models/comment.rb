class Comment < ActiveRecord::Base
  belongs_to :post

  belongs_to :author, class_name: "User",
                      foreign_key: :user_id

  has_many :likings, as: :likeable
  has_many :users_liked, through: :likings, source: :user
                   

  def nb_user_like(liked)
    self.users_liked.first.full_name + (liked-1 > 0 ? ( " and " + pluralize(liked-1, "User") ) : "") 
  end
end
