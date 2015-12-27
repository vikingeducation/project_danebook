class Like < ActiveRecord::Base
    belongs_to :user
    belongs_to :likeble, :polymorphic => true
    validates_uniqueness_of :user_id, :scope => [ :likeble_id, 
                                                :likeble_type]
end
