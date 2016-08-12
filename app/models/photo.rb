class Photo < ApplicationRecord
  belongs_to :post, :as => :postable
end
