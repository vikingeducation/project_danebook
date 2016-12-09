class RemoveSexAndBirthdayFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :sex
    remove_column :users, :birthday
  end
end
