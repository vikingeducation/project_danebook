class AddAboutToUser < ActiveRecord::Migration
  def change
    add_column :users, :college_name, :string
    add_column :users, :hometown, :string
    add_column :users, :current_home, :string
    add_column :users, :telephone, :string
    add_column :users, :words_live_by, :text
    add_column :users, :about_me, :text
  end
end
