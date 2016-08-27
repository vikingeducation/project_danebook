class RemovePointersFromAddresses < ActiveRecord::Migration
  def change
    # Remove pointers to tables.
    remove_column :addresses, :city_id
    remove_column :addresses, :state_id
    remove_column :addresses, :country_id
    
    # Dropping the tables.
    drop_table :cities
    drop_table :states
    drop_table :countries
  end
end
