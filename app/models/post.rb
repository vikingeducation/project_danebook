class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  has_many :comments

  validates :description,
            :length => {in: 1..800}
end
