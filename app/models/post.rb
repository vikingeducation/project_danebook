class Post < ApplicationRecord

  validates :content, presence: true

  has_one :activity, :as =>:postable
  has_one :owner, through: :activity, source: :author
end
