class CreateFriendings < ActiveRecord::Migration
  def change
    create_table :friendings do |t|
      t.belongs_to :friender
      t.belongs_to :friendee

      t.timestamps
    end
  end
end
