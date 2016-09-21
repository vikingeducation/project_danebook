class Video < ApplicationRecord
  has_one :post, :as => :postable
end
