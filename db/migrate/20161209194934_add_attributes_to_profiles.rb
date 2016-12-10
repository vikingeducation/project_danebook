class AddAttributesToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :college, :string
    add_column :profiles, :hometown, :string
    add_column :profiles, :city, :string
    add_column :profiles, :telephone, :string
    add_column :profiles, :words_to_live_by, :text
    add_column :profiles, :about_me, :text
  end
end
