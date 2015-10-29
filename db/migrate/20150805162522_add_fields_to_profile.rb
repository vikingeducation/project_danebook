class AddFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :college, :string
    add_column :profiles, :hometown, :string
    add_column :profiles, :currently_lives, :string
    add_column :profiles, :telephone, :string
    add_column :profiles, :words_to_live_by, :text
    add_column :profiles, :description, :text
  end
end
