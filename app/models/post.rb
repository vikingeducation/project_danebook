class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :comments

  has_many :likings, as: :likeable
  has_many :users_liked, through: :likings, source: :user

  validates :author, presence: true
  validates :body, :author_id, presence: true


  def nb_user_like(liked)
    self.users_liked.first.full_name + (liked-1 > 0 ? ( " and " + pluralize(liked-1, "User") ) : "") 
  end
end
