class Post < ApplicationRecord

  validates :body, presence: true

  belongs_to :user
  has_many :likes
  has_many :comments

  def like_list
    likes.map {|like| like.user.profile.name}.join(", ")
  end

end
