class PostText < ApplicationRecord
  belongs_to :post, :as => :postable
end
