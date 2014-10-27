class ChangeColumnName < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :address_id
      t.remove :current_address_id

      t.integer :location_id
      t.integer :current_location_id
    end
  end
end
