class Addsignupdetails < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    change_column :users, :first_name, :string, :null => false
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :b_month, :integer
    add_column :users, :b_day, :integer
    add_column :users, :b_year, :integer
    change_column :users, :last_name, :string, :null => false
    change_column :users, :gender, :string, :null => false
    change_column :users, :b_month, :integer, :null => false
    change_column :users, :b_day, :integer, :null => false
    change_column :users, :b_year, :integer, :null => false

  end
end
