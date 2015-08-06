class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :college, :string
    add_column :profiles, :hometown, :string
    add_column :profiles, :location, :string
    add_column :profiles, :phone, :string
    add_column :profiles, :motto, :text
    add_column :profiles, :about, :text
  end
end
