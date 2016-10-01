class Post < ApplicationRecord
  validates :text, length: { maximum: 500 }

  belongs_to :user
end
