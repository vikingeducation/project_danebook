class RemoveUniqueFromPasswordDigest < ActiveRecord::Migration
  def change
    remove_index :users, :password_digest
    add_index :users, :password_digest
  end
end
