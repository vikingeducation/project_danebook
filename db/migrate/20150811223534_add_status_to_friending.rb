class AddStatusToFriending < ActiveRecord::Migration
  def change
  	add_column :friendings, :status, :string
  end
end
