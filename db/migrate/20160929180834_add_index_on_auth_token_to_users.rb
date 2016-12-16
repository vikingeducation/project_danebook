class AddIndexOnAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :auth_token, :unique => true
  end
end
