class RemoveEmailFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :email
  end
end
