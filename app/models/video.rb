class Video < ApplicationRecord
  belongs_to :post, :as => :postable
end
