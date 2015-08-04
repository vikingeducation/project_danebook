class Like < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user
  belongs_to :post

  # ----------------------- Methods --------------------

  def self.search_record(post_id, user_id)
    find_by({post_id: post_id, user_id: user_id })
  end


end
