class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, :as => :likeable, dependent: :destroy

  validates :body, presence: true

  def sample_liker
    self.likes.map {|like| like.user.name }.first unless no_likes?
  end

  def no_likes?
    self.likes.empty?
  end

end
