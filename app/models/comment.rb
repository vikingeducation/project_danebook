class Comment < ApplicationRecord
  include Likeable
  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
