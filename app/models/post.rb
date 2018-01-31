class Post < ApplicationRecord

  belongs_to :user
  include Liking
  include Commenting

  validates :user_id, :user, :body, presence: true

end
