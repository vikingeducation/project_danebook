class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :college,   :string
    add_column :users, :home_town, :string
    add_column :users, :current_lives, :string
    add_column :users, :telephone,     :string
    add_column :users, :birthday,      :datetime
    add_column :users, :words_to_live_by, :text
    add_column :users, :about,            :text
  end
end
