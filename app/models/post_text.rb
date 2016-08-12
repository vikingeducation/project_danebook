class PostText < ApplicationRecord
  has_one :post, :as => :postable
end
