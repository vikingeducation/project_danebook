class Post < ApplicationRecord
  has_one :activity, :as =>:postable
  has_one :owner, through: :activity, source: :author
end
