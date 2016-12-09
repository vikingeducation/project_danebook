class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post,  counter_cache: true

  validates_uniqueness_of :user_id, scope: [:post_id]

end
