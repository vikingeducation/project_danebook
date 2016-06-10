class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :likings

  has_many :users_liked, through: :likings,
                         source: :user

  def nb_user_like(liked)
    self.users_liked.first.full_name + (liked-1 > 0 ? ( " and " + pluralize(liked-1, "User") ) : "") 
  end
end
