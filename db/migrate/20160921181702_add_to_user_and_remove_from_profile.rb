class AddToUserAndRemoveFromProfile < ActiveRecord::Migration[5.0]
  def change

    remove_column :profiles, :first_name
    remove_column :profiles, :last_name
    remove_column :profiles, :gender
    remove_column :profiles, :birthdate

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :birthdate, :date
  end
end
