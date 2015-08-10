class Photo < ActiveRecord::Base
  has_attached_file :uploaded_file
  has_many :comments, -> { order('created_at ASC') }, as: :commentable, dependent: :destroy

  include Commentable

  def has_likes?
    self.likes.count > 0
  end
end
