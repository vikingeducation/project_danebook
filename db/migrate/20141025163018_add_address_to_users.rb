class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_address_id, :integer
  end
end
