class Like < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user

  belongs_to :likeable, :polymorphic => true

  # Make sure we validate uniqueness to avoid duplicate likes.
  validates :user_id, :uniqueness => { :scope => [:likeable_id, :likeable_type] }

  validates :user_id, :likeable_id, :likeable_type,
            presence: true

  # ----------------------- Methods --------------------

  def self.search_record(likeable_type, likeable_id, user_id)
    find_by({
              likeable_type: likeable_type,
              likeable_id: likeable_id,
              user_id: user_id })
  end


end
