class Post < ApplicationRecord

  belongs_to :user

  validates_presence_of :body, :user
  validates :body, length: { maximum: 500 }

end
