class AddBirthdayAndSexColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthday, :date
    add_column :users, :gender_cd, :integer
  end
end
