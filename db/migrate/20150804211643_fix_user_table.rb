class FixUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :college
    remove_column :users, :hometown
    remove_column :users, :current_town
    remove_column :users, :telephone
    remove_column :users, :words_to_live_by
    remove_column :users, :about_me
  end
end
