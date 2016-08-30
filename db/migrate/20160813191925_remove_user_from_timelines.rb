class RemoveUserFromTimelines < ActiveRecord::Migration
  def change
    remove_column :timelines, :user_id
  end
end
