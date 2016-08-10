class RemoveAddressIdFromCountries < ActiveRecord::Migration
  def change
    remove_column :countries, :address_id
  end
end
