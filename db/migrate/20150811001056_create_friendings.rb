class CreateFriendings < ActiveRecord::Migration
  def change
    add_column :friendings do |t|
      t.index [:user_id, :friend_id], null: false, unique: true
      t.index [:friend_id, :user_id], null: false, unique: true
      
      t.timestamps null: false
    end
  end
end
