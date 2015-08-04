class AddBirthdateToUser < ActiveRecord::Migration
  def change
    remove_column :users, :birthdate_id, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_day, :integer
    add_column :users, :birth_year, :integer
  end
end
