class Post < ApplicationRecord
  has_one :activity, :as =>:postable
  has_one :user, through: :activity
end
