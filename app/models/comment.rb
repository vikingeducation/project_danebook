class Comment < ApplicationRecord
  has_many :likes, :as => :likeable
  validates :body, presence: true
end
