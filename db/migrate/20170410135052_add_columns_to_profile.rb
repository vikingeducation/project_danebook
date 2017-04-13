class AddColumnsToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :college, :string
    add_column :profiles, :hometown, :string
    add_column :profiles, :current_city, :string
    add_column :profiles, :telephone, :string
    add_column :profiles, :quote, :string
    add_column :profiles, :about, :text
  end
end
