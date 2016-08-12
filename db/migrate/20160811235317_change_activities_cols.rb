class ChangeActivitiesCols < ActiveRecord::Migration[5.0]
  def change
    rename_column :activities, :activity_type, :postable_type
    rename_column :activities, :activity_id, :postable_id
  end
end
