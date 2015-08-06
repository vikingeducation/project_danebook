class Like < ActiveRecord::Base
  belongs_to :duty, :polymorphic => true
end
