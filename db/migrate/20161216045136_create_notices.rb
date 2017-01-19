class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.references :user, foreign_key: true
      t.boolean :viewed, default: false
      t.string :title
      t.string :messages, array: true, default: []

      t.timestamps
    end
  end
end
