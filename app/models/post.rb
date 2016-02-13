class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts

  validates :body, presence: true, length: { maximum: 2000 }

end
