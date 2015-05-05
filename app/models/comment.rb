class Comment < ActiveRecord::Base
  has_one :post
  belongs_to :user 
end
