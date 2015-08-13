class PostLiking < ActiveRecord::Base

  #dont think this is being used either
  belongs_to :post
  belongs_to :like
end
