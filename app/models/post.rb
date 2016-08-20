class Post < ApplicationRecord

  validates :body, presence: true

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  def like_list
    likes.map {|like| like.user.profile.name}.join(", ")
  end

end
