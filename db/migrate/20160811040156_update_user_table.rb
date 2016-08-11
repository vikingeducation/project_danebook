class UpdateUserTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :birth_day, :integer
    add_column :users, :birth_month, :string
    add_column :users, :birth_year, :integer
  end
end
