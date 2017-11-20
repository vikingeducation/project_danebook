class Comment < ApplicationRecord

  belongs_to :commentable, :polymprphic => true
end
