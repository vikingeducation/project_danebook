class PolymorphicParentActivity < ActiveRecord::Migration[5.0]
  def change
    rename_column :activities, :user_id, :ownable_id
    add_column :activities, :ownable_type, :string
  end
end
