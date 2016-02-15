class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 2000 }

end
