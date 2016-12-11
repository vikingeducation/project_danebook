class Image < ApplicationRecord
  belongs_to :gallery, inverse_of: :images
end
