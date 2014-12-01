class MakePasswordOptional < ActiveRecord::Migration

  def up
   change_column :users, :password_digest, :string, null: true
  end

  def down
   change_column :users, :password_digest, :string, null: false
  end

end
