class AddCountryToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :country, index: true, foreign_key: true
  end
end
