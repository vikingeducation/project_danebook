class AddCityToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :city, index: true, foreign_key: true
  end
end
