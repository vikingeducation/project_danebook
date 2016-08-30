class AddDefaultsToAddresses < ActiveRecord::Migration
  def change
    change_column :addresses, :street_address, :string, defaults: ''
    change_column :addresses, :city, :string, defaults: ''
    change_column :addresses, :state, :string, defaults: ''
    change_column :addresses, :country, :string, defaults: ''
    change_column :addresses, :zip_code, :string, defaults: ''
    change_column :addresses, :country, :string, defaults: ''
  end
end
