class CreateFriendings < ActiveRecord::Migration
  def change
    drop_table :friendings
    drop_table :friends_users
    create_table :friendings do |t|
      t.integer :user_id,  null: false, unique: true
      t.integer :friend_id, null: false, unique: true
      

      t.timestamps null: false
    end
  end

  
end
