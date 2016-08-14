class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.integer :initiatior_id
      t.integer :reciever_id

      t.timestamps
    end
  end
end
