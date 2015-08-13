class AddUserColumnsBack < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :birthday, :datetime
  end
end
