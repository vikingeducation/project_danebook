class AddProfileTextAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :about_me, :text
    add_column :profiles, :words_to_live_by, :text
  end
end
