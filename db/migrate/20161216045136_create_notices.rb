class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.references :user, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
