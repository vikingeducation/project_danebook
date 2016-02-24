class AddIndexesToProfiles < ActiveRecord::Migration
  def change
    add_index :profiles, :first_name
    add_index :profiles, :last_name
  end
end
