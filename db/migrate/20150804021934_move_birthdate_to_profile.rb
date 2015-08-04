class MoveBirthdateToProfile < ActiveRecord::Migration
  def change
    remove_column :users, :birth_month, :integer
    remove_column :users, :birth_day, :integer
    remove_column :users, :birth_year, :integer
  end
end
