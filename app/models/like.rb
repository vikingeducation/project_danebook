class Like < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user

  belongs_to :likeable, :polymorphic => true

  # ----------------------- Methods --------------------

  def self.search_record(likeable_type, likeable_id, user_id)
    find_by({
              likeable_type: likeable_type,
              likeable_id: likeable_id,
              user_id: user_id })
  end


end
