class RemovePolyOwndershipFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :ownable_id
    remove_column :activities, :ownable_type
    add_column :activities, :author_id, :integer
  end
end
