class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birth_date, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_year, :integer
    add_column :users, :gender, :boolean
  end
end
