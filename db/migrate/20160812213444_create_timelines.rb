class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
