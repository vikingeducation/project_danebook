class MoveNamesToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :first_name, :string
    remove_column :profiles, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
