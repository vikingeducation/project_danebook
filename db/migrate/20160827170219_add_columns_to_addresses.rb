class AddColumnsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :street_address, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :zip_code, :string
    add_column :addresses, :country, :string
  end
end
