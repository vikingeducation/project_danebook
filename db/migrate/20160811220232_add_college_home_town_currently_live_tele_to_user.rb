class AddCollegeHomeTownCurrentlyLiveTeleToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :college, :string
    add_column :users, :hometown, :string
    add_column :users, :current_add, :string
    add_column :users, :tele, :string
  end
end
