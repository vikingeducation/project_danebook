class RemoveProfileFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :college_name
    remove_column :users, :hometown
    remove_column :users, :current_home
    remove_column :users, :telephone
    remove_column :users, :words_live_by
    remove_column :users, :about_me
  end
end
