class RemoveColumnsFromUserModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :birth_month
    remove_column :users, :birth_day
    remove_column :users, :birth_year
    remove_column :users, :gender
    remove_column :users, :college
    remove_column :users, :hometown
    remove_column :users, :current_town
    remove_column :users, :phone
    remove_column :users, :words_to_live_by
    remove_column :users, :about_me
  end
end
