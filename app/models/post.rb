class Post < ApplicationRecord
  belongs_to :user

  validates :body, length: { maximum: 10000 }
end
