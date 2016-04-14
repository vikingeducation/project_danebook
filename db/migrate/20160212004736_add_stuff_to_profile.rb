class AddStuffToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :about_me, :text
    add_column :profiles, :words_to_live_by, :text
    add_column :profiles, :hometown, :text
    add_column :profiles, :current_city, :text
  end
end
