class Post < ActiveRecord::Base
  has_many :comments, -> { order('created_at ASC') }, as: :commentable, dependent: :destroy

  include Commentable

  def has_likes?
    self.likes.count > 0
  end

end
