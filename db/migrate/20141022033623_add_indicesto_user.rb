class AddIndicestoUser < ActiveRecord::Migration
  def change
    add_index :users, :email
    add_index :users, :auth_token, :unique => true
  end
end
