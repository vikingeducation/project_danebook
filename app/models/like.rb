class Like < ActiveRecord::Base

  belongs_to :likings, :polymorphic => true

end
