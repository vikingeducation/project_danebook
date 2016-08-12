class Photo < ApplicationRecord
  has_one :post, :as => :postable
end
