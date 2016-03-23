class AddIndexesToLikes < ActiveRecord::Migration
  def change
    add_index "likes", ["likeable_type", "likeable_id"]
    add_reference :likes, :user, index: true
  end
end
