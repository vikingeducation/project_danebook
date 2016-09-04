class Post < ApplicationRecord
  include Likeable
  include Commentable
  belongs_to :user


  validates :body, presence: true

  def sample_liker
    self.likes.map {|like| like.user.name }.first unless no_likes?
  end

  def no_likes?
    self.likes.empty?
  end

  def has_likes?
    !no_likes?
  end

  def has_comments?
    !self.comments.empty?
  end

end
