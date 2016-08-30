class RemoveAddressIdFromStates < ActiveRecord::Migration
  def change
    remove_column :states, :address_id
  end
end
