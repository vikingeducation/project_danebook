class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  include Liking

  validates :body, presence: true

end
