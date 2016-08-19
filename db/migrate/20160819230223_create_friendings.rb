class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|

      t.timestamps
    end
  end
end
