class RemoveAddressIdFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :address_id
  end
end
