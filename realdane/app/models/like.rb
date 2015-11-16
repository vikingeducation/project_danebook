class Like < ActiveRecord::Base
    belongs_to :user
    belongs_to :user_chat, :polymorphic => true
end
